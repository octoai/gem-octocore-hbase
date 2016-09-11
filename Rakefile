require 'massive_record'
require 'yaml'
require 'redis'
require 'rspec/core/rake_task'
require 'octocore-hbase/helpers/kong_helper'
require 'octocore-hbase/config'
require 'octocore-hbase/utils'

RSpec::Core::RakeTask.new('spec')

task :environment do
  config_dir = ENV['CONFIG_DIR'] || 'lib/octocore-hbase/config/'
  config = {}
  Dir[config_dir + '**{,/*/**}/*.yml'].each do |file|
    _config = YAML.load_file(file)
    if _config
      puts "loading from file: #{ file }"
      config = config.merge(_config.deep_symbolize_keys)
    end
  end
  Octo.load_config config

  MassiveRecord::ORM::Base.connection_configuration = Octo.get_config(:hbase)
end

# Overriding rake actions
namespace :octo do

  desc 'Create keyspace and tables for all defined models'
  task :init => %w(environment octo:migrate)

  desc 'Drop keyspace if exists, then create and migrate'
  task :reset => :environment do
    kong_delete
    clear_cache

    drop

    migrate
  end

  desc "Delete all tables"
  task :drop => :environment do
    drop
  end

  desc "Synchronize all models defined in `lib/octocore-hbase/models' with HBase " \
       "database schema"
  task :migrate => :environment do
    migrate
  end
end

# Delete Kong Consumers and Apis
def kong_delete
  kong_config = Octo.get_config :kong
  if kong_config[:enabled]
    Octo::Helpers::KongBridge.delete_all
    puts 'Kong Cleaned'
  end
end

# Clear Cache
def clear_cache
  default_cache = {
    host: '127.0.0.1', port: 6379
  }
  redis = Redis.new(default_cache.merge(driver: :hiredis))
  redis.flushall
  puts 'Cache Cleaned'
end

def drop

  watch_stack = ActiveSupport::Dependencies::WatchStack.new
  watch_namespaces = ['Octo']
  watch_stack.watch_namespaces(watch_namespaces)

  project_root = Dir.pwd
  models_dir_path = "#{File.expand_path('lib/octocore-hbase/models', project_root)}/"
  model_files = Dir.glob(File.join(models_dir_path, '**', '*.rb'))

  model_files.sort.each do |file|
    watch_stack.watch_namespaces(watch_namespaces)
    require_dependency(file)
    new_constants = watch_stack.new_constants

    new_constants.each do |konst|
      if Octo.const_get(konst).ancestors.include?(MassiveRecord::ORM::Table)
        clazz = konst.constantize
        table_exists = clazz.send(:table_exists?)
        if table_exists
          clazz.send(:table).send(:destroy)
          puts "Deleted table: #{ clazz }"
        else
          puts "Table does not exist : #{ clazz }"
        end
      end
    end

  end

end

def migrate



  watch_stack = ActiveSupport::Dependencies::WatchStack.new
  watch_namespaces = ['Octo']
  watch_stack.watch_namespaces(watch_namespaces)

  project_root = Dir.pwd
  models_dir_path = "#{File.expand_path('lib/octocore-hbase/models', project_root)}/"
  model_files = Dir.glob(File.join(models_dir_path, '**', '*.rb'))

  tables = {}

  model_files.sort.each do |file|
    watch_stack.watch_namespaces(watch_namespaces)
    require_dependency(file)
    new_constants = watch_stack.new_constants

    new_constants.each do |konst|
      if Octo.const_get(konst).ancestors.include?(MassiveRecord::ORM::Table)
        clazz = konst.constantize
        if clazz.send(:table_exists?)
          puts "Table Exists: #{ clazz.send(:table_name) }"
        else
          tables[clazz.table_name] = clazz.column_families.collect { |x| x.name }
        end
      end
    end
  end


  # We are creating HBase shell commands and passing them to hbase shell
  # These hbase shell commands are create commands.
  # This is a workaround for some of the issues mentioned at
  # https://github.com/CompanyBook/massive_record/issues/95
  tables.each do |name, col_families|
    puts "Creating Table: #{ name }"
    hbase_path = ENV['HBASE_PATH_BIN'] || Octo.get_config(:hbase_path_bin)
    cmd = "echo \"create '#{ name }', '#{ col_families.join(',') }' \" |  #{ hbase_path }/hbase shell "
    `#{ cmd }`
  end

end

