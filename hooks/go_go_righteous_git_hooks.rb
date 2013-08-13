require_relative 'linked-files-not-in-repo'
include RighteousGitHooks

if ARGV.length < 3 then
	puts "You must supply 3 arguments: git_repo_dir, project_dir, csproj_filename"
	exit 1
end

git_repo_dir = ARGV[0]
project_dir = ARGV[1]
csproj_filename = ARGV[2]

the_righteous = LinkedFilesChecker.new(git_repo_dir, project_dir, csproj_filename)

result = the_righteous.make_it_so!

puts result.message
exit result.status_code