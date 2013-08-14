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
			
			Dir.chdir(@git_root) do
				# CSS Selectors for maximum coolness (also XPath sucks)
				csproj.css('ItemGroup > Content[Include]').each do |content|
					# Get the repo-relative path for each file with unix-style path separators
					path = File.join(@project_dir, content['Include'].gsub('\\', '/'))
					# Check the file is staged in Git. An empty response means it's not staged
					puts "content = #{content}"
					puts "COMMAND = git ls-files --stage #{path}"
					result = `git ls-files --stage #{path}`
					puts result
					sins.push(path) if result.empty?
				end
			end

			return Result.success("Congratulations, this is a righteous commit!") if sins.empty?

			message = "\nYou have sinned! The following files are csproj links, but exist in your repo..."
			sins.each do |sin|
				message = message + "\n#{sin}"
			end
			message = message + "\nPlease delete them before committing. You may need to add them to .gitignore as well."
			
			return Result.error(message)
		end
	end
end