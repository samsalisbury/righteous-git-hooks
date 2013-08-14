# 1. Copy the solution and make a new git repo
# 2. Init a new git repo, and commit status quo
# 3. Get the commit sha, then poke around in the repo and try to commit, running the tests...

require 'securerandom'

def generate_dirname()
	"~/.righteous-git-hooks-temp-test-repo-" + SecureRandom.uuid[0..7]
end

temp_dir = File.expand_path(generate_dirname())
if File.directory? temp_dir
	puts "Directory #{temp_dir} already exists, can't continue."
	exit 1
end

`mkdir #{temp_dir}`

tests_root = File.expand_path(File.dirname(__FILE__))

master_data_dir = File.join(tests_root, 'GitHooksTestSolution')
hook_script = File.join(tests_root, "../hooks/go_go_righteous_git_hooks.rb")

a_test_failed = 0

Dir.chdir(File.expand_path(temp_dir)) do
	# Arrange - copy files, create test repo and commit
	`cp -r #{master_data_dir}/* #{temp_dir}`
	`git init`
	`git add -A`
	`git commit -m 'Test commit.'`
	# Act
	result = `ruby #{hook_script} $PWD GitHooksTest GitHooksTest.csproj`
	# Assert
	if result.split("\n").last == 'Congratulations, this is a righteous commit!' then
		puts 'Test passed!'
	else
		puts 'Test failed.'
		a_test_failed += 1
	end
end

# clean up directory
`rm -rf #{temp_dir}`

exit a_test_failed