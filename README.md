ctocore-hbase

This is the Octomatic Enterprise Core gem for HBase. It provides most of the ORM stuff, Class and modules for different HBase tables.

## Pre-Install

The below steps are for Mac. For your operating system, there must exist a way which must be found and must be updated here.

- Install hbase `brew install hbase`
- Install thrift `brew install thrift`
- Hadoop `brew install hadoop`

## Installting

```bash
gem install octocore-hbase
```

In case you are using bundler, you need to add something like this to your Gemfile:

```ruby
gem 'octocore-hbase', :git => 'git@github.com:octoai/gem-octocore-hbase.git'
```

#### Troubleshooting

- Mac
  - [http://stackoverflow.com/questions/36378190/cant-install-thrift-gem-on-os-x-el-capitan](http://stackoverflow.com/questions/36378190/cant-install-thrift-gem-on-os-x-el-capitan)
  - [http://stackoverflow.com/questions/5167829/how-can-i-pass-a-parameter-for-gem-installation-when-i-run-bundle-install](http://stackoverflow.com/questions/5167829/how-can-i-pass-a-parameter-for-gem-installation-when-i-run-bundle-install)


## DB Utilities

### Migrations

For migrations it needs hbase binary directory's path as `HBASE_PATH_BIN`.

```shell
rake octo:migrate CONFIG_DIR=~/workspace/octo/current/config/ HBASE_PATH_BIN=/Users/pranav/etc/hbase-0.94.15-cdh4.7.1/bin
```

### Drop

Only `CONFIG_DIR` is required here.

```shell
rake octo:drop CONFIG_DIR=~/workspace/octo/current/config
```


Where

- `action`: The action to be performed. One of `init`, `migrate` or `reset`
- `/path/to/config/dir`: The path where your config dir is placed


# Development

## Clone the repo

`$ git clone git@github.com:octoai/gem-octocore-hbase.git`

## Building

```bash
$ ./bin/clean_setup.sh
```

## Specs

```bash
$ rake spec
```

# Verifying connectivity

You can use the following set of commands in `irb` to verify all things working with this gem. Execute it from irb in PROJ_DIR.

```ruby
require 'octocore-hbase'
config_dir = '/path/to/config/dir'
Octo.connect_with_config_file config_dir
```

# Creating fake stream

It ships with a utility called `fakestream`. It will automatically stream random data. To use just open your console and type

```bash
$ fakestream-hbase /path/to/config/dir
```
