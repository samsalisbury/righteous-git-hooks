require 'nokogiri'

puts 'Checking linked files in your csproj are not in the repository...'

def DebugLog(message)
	# This should check for an env var, but can't get it working on windows...
	puts message
end

git_root = File.absolute_path(File.dirname(__FILE__) + '/..')

DebugLog "The root of your git repo is at '#{git_root}'"

relative_project_dir = 'project/root/in/repo'
project_dir = File.join(git_root, relative_project_dir)
csproj_path = File.join(project_dir, 'project-name.csproj')

DebugLog "Project directory: '#{project_dir}'"
DebugLog "Checking csproj:   '#{csproj_path}'"

xml = File.read(csproj_path)

csproj = Nokogiri::XML(xml)

list = []

# CSS Selectors for maximum coolness
csproj.css('ItemGroup > Content > Link').each do |link|
	# Get the repo-relative path for each file with unix-style path separators
	path = File.join(relative_project_dir, link.text.gsub('\\', '/'))
	result = `git ls-files --stage #{path}`
	list.push(result) if not result.empty?
end

if list.empty? then
	puts "Congratulations, this is a righteous commit!"
end

puts 'ERROR: The following files are csproj links, but exist in your repo...'
list.each do |item|
	puts item
end
puts 'Please delete them before committing. You may need to add them to .gitignore as well.'
exit 1