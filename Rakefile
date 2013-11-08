desc 'Print help.'
task :default do
	puts 'Try `rake -T` to list tasks.'
end

namespace :test do

	desc 'Run simple tests.'
	task :simple do
		sh './test/runtests.sh'
	end

end

desc 'Run all tests.'
task :test do
	Rake.application.in_namespace(:test) { |x| x.tasks.each { |t| t.invoke } }
end