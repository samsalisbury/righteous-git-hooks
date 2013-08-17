Gem::Specification.new do |s|
  s.name              = "righteous"
  s.version           = "0.0.0"
  s.platform          = Gem::Platform::RUBY
  s.author           = "Samuel R. Salisbury"
  s.email             = "samsalisbury@gmail.com"
  s.homepage          = "http://github.com/samsalisbury/righteous-git-hooks"
  s.summary           = "ALPHA: Useful, easy-install Git hooks for Visual Studio projects and more."
  s.description       = "ALPHA: Managing the Git sins and foibles of a large development team on Git-unfriendly Windows was becoming a nightmare at work. I started writing hooks to mitigate some of the most common mistakes, and realised to get them adopted, they need to be really easy to set up. Thus, I'm starting this project to make headway into having useful git hooks anyone can use with minimal effort."
  
  s.rubyforge_project = s.name

  s.required_rubygems_version = ">= 1.3.6"
 
  # If you have runtime dependencies, add them here
  # s.add_runtime_dependency "other", "~&gt; 1.2"
 
  # If you have development dependencies, add them here
  # s.add_development_dependency "another", "= 0.9"
 
  # The list of files to be contained in the gem 
  s.files         = `git ls-files`.split("\n")
  # s.executables   = `git ls-files`.split("\n").map{|f| f =~ /^bin\/(.*)/ ? $1 : nil}.compact
  # s.extensions    = `git ls-files ext/extconf.rb`.split("\n")
 
  s.require_path = 'lib'
 
  # For C extensions
  # s.extensions = "ext/extconf.rb"
end