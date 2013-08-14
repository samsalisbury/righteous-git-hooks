require_relative 'linked-files-not-in-repo'
require_relative 'content-files-are-in-repo'
include RighteousGitHooks

if ARGV.length < 3 then
	puts "You must supply at least 3 arguments: git_repo_dir, project_dir, csproj_filename"
	exit 1
end

git_repo_dir = ARGV[0]
project_dir = ARGV[1]
csproj_filename = ARGV[2]
checker = ARGV[3]

checker = 'all' if checker.empty?

results = []

if checker == 'all' or checker == 'linked-files' then
	the_righteous_linked_files_checker = LinkedFilesChecker.new(git_repo_dir, project_dir, csproj_filename)
	results.push the_righteous_linked_files_checker.make_it_so!
end
if checker == 'all' or checker == 'content-files' then
	the_righteous_content_files_checker = ContentFilesChecker.new(git_repo_dir, project_dir, csproj_filename)
	results.push the_righteous_content_files_checker.make_it_so!
end

results.each { |r| puts r.message }

exit results.any? { |r| r.status_code > 0 } ? 1 : 0