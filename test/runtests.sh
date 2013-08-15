#!/bin/bash
test_dir=$(dirname $0)
ruby "$test_dir/content-files-are-in-repo-tests.rb"
ruby "$test_dir/linked-files-not-in-repo-tests.rb"