require 'nokogiri'
require_relative 'result'

module RighteousGitHooks

	class ContentFilesChecker

		def initialize(git_root, project_dir, csproj_filename)
			@git_root = git_root
			@project_dir = project_dir
			@csproj_filename = csproj_filename
		end

		def make_it_so!()
			
			puts 'Checking content files are in your repository...'
			csproj_path = File.join(@git_root, @project_dir, @csproj_filename)

			return Result.error("Cannot find #{csproj_path}") unless File.exists? csproj_path

			puts "Checking csproj: '#{csproj_path}'"
			csproj = Nokogiri::XML(File.read(csproj_path))
			sins = []
			
			# Make list of all files from repo
			# Make list of all files from csproj
			# Make sure they're the same!

			content_files = []
			repo_files = []

			Dir.chdir(@git_root) do
				repo_files = `git ls-files`.split("\n")
			end

			csproj.css('ItemGroup > Content[Include]').each do |content|
				
				next unless (content > "DependentUpon").empty?
				test_path = File.expand_path(File.join(@project_dir, content['Include'].gsub('\\', '/'))).gsub(@git_root + '/', '')
				unless repo_files.include? test_path then
					sins.push(test_path)
				end
			end

			return Result.success("Congratulations, this is a righteous commit!") if sins.empty?

			message = "\nYou have sinned! The following #{sins.length} files are csproj content files, but do not exist in your repo..."
			sins.each do |sin|
				message = message + "\n#{sin}"
			end
			message = message + "\nPlease add all #{sins.length} files or specify that they're DependentUpon in the csproj before committing."
			
			return Result.error(message)
		end
	end
end