# 1. Copy the solution and make a new git repo
# 2. Init a new git repo, and commit status quo
# 3. Get the commit sha, then poke around in the repo and try to commit, running the tests...

require 'securerandom'
require 'command-unit'

include CommandUnit

def generate_dirname()
	"~/.righteous-git-hooks-temp-test-repo-" + SecureRandom.uuid[0..7]
end

scenario "Solution has linked files and none of them are in the repository" do
	
	tests_root = File.expand_path(File.dirname(__FILE__))
	temp_dir = File.expand_path(generate_dirname())
	master_data_dir = File.join(tests_root, 'GitHooksTestSolution')
	hook_script = File.join(tests_root, "../lib/hooks/go_go_righteous_git_hooks.rb")

	scenario_set_up do |context|
		if File.directory? temp_dir
			puts "Directory #{temp_dir} already exists, can't continue."
			exit 1
		end

		`mkdir #{temp_dir}`
		
		Dir.chdir(temp_dir) do
			# Copy files, create test repo and commit
			`cp -r #{master_data_dir}/* #{temp_dir}`
			`git init`
			`git add -A`
			`git commit -m 'Test commit.'`
		end
	end

	set_up do |context|
		Dir.chdir(temp_dir) do
			# Reset to the original commit
			`git reset --hard`
			`git clean -xdf`
		end
	end

	when_i 'run the linked files checker' do |context|
		Dir.chdir(temp_dir) do
			context[:result] = `ruby #{hook_script} $PWD GitHooksTest GitHooksTest.csproj linked-files`
		end
	end

	i_expect 'to see a congratulations message' do |context|
		Dir.chdir(temp_dir) do
			# Assert
			if context[:result].split("\n").last == 'Congratulations, this is a righteous commit!' then
				pass
			else
				puts 'Test failed.'
				fail
			end
		end
	end

	scenario_tear_down do |context|
		# clean up directory
		`rm -rf #{temp_dir}`
	end

end

run
