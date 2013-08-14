# Righteous Git Hooks
Useful Git hooks for Visual Studio projects on Windows

_Note: This project is in its infancy, I need to wrap the tests in some kind of framework, add more hooks and tests, and build the installer. I'll probably make this available as a gem at some point as well..._

## What?
These hooks are born out of frustration working with large complicated Visual Studio solutions, in large teams, where there are constant issues, such as:

* _Generated files (using .csproj `dependentupon` elements, e.g. CSS from SCSS or JavaScript from CoffeeScript) get added to the repository. [NOT IMPLEMENTED]_
* Linked files (using .csproj `link` elements) get added to the repository.
* _Content files get added to the project, but not to Git, resulting in working builds, but broken deployments. [NOT IMPLEMENTED]_
* _On Windows, incorrect Git config can result in multiple folders with names differing only by case, which causes other problems [NOT IMPLEMENTED]:_
	- _Browsing the repository on GitHub becomes problematic._
	- _Some users will not receive all the files when they check out a branch._
	- _Git will in some cases track two separate files in the index, representing only one on disk._

Clearly, these are all problematic situations. Righteous Git Hooks aims to solve all of the above problems with code :)

## Installation

Currently this is largely a manual process, I'll be aiming to improve this in the future. Any help with making the hooks more universal, easier to set up, or adding additional hooks, would be much appreciated.

### Requirements:
1. [Msys Git (i.e. Git for Windows) v1.8+](http://git-scm.com/download/win)
2. [Ruby 1.9.3](http://rubyinstaller.org/downloads/) (not tested for other versions of Ruby, help with this appreciated)

### Instructions:
1. Open an admin command prompt
	* Windows 8: Hit Windows Key -> type "cmd" -> right click "Command Prompt" -> Select "Run as administrator" from the footer menu.
2. In the console:
	* `C:\>gem install bundler`
	* `C:\>cd righteous-git-hooks`
	* `C:\>bundle install`
3. Manually invoke righteous-pre-commit.sh from your repository's .git/hooks/pre-commit file.
	* The plan is to automate this step with an installer ASAP.