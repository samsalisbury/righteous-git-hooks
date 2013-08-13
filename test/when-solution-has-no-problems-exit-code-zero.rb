

result = `ruby hooks/go_go_righteous_git_hooks.rb $PWD test/GitHooksTestSolution/GitHooksTest GitHooksTest.csproj`

if result.split("\n").last == 'Congratulations, this is a righteous commit!' then
	puts 'Tests passed!'
	exit 0
end

puts 'Tests failed!'
exit 1