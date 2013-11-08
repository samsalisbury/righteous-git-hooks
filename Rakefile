desc 'Print help.'
task :default do
	puts 'Try rake -D to list tasks.'
end

namespace :test do

	desc 'Run all tests.'
	task :all do
		puts 'Running tests...'
		out = `sh ./test/runtests.sh`
		puts out
	end

end