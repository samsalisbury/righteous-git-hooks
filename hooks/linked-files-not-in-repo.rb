require 'nokogiri'
require_relative 'result'

module RighteousGitHooks

	class LinkedFilesChecker

		def initialize(git_root, project_dir, csproj_filename)
			@git_root = git_root
			@project_dir = project_dir
			@csproj_filename = csproj_filename
		end

		def make_it_so!()
			
			puts 'Checking linked files in your csproj are not in the repository...'
			csproj_path = File.join(@git_root, @project_dir, @csproj_filename)

			return Result.error("Cannot find #{csproj_path}") unless File.exists? csproj_path

			puts "Checking csproj: '#{csproj_path}'"
			csproj = Nokogiri::XML(File.read(csproj_path))
			sins = []
			# CSS Selectors for maximum coolness (also XPath sucks)
			csproj.css('ItemGroup > Content > Link').each do |link|
				# Get the repo-relative path for each file with unix-style path separators
				path = File.join(@project_dir, link.text.gsub('\\', '/'))
				# Check the file is not staged in Git. An empty response means it's not staged
				result = `git ls-files --stage #{path}`
				sins.push(result) unless result.empty?
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