#!/bin/sh
# This file causes all of the Git hooks to be invoked.
# Your pre-commit file (in .git/hooks) just needs to
# invoke this file, e.g.
#
#     source ../git-hooks/justgiving-git-hooks.sh
echo 'Examining your staged commit for ultimate righteousness...'
ruby 'git-hooks/linked-files-not-in-repo.rb'