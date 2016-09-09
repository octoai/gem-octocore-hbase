rm *.gem
gem build octocore-hbase.gemspec && gem uninstall octocore-hbase --force


# Building thrift can be pretty complicated.
# The version of massive_record supports thrift v 0.6.0
# Installing thrift sometimes generate errrors, which is why
# we here prefer to install thrift first and then proceed
# with the installation of our gem.


case "$OSTYPE" in
  solaris*) echo "If this step fails, install thrift manually and update this file for SOLARIS" ;;
  darwin*)  gem install thrift -v 0.6.0 -- --with-cppflags='-D_FORTIFY_SOURCE=0 -Wno-shift-negative-value';;
  linux*)   echo "If this step fails, install thrift manually and update this file for LINUX" ;;
  bsd*)     echo "If this step fails, install thrift manually and update this file for BSD" ;;
  *)        echo "If this step fails, install thrift manually and update this file for OS: unknown: $OSTYPE" ;;
esac


find . -name '*.gem' | xargs gem install
