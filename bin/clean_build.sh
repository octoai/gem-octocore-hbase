rm *.gem
gem build octocore.gemspec && gem uninstall octocore --force
find . -name '*.gem' | xargs gem install
