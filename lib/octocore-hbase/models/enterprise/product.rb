require 'massive_record'
require 'octocore-hbase/record'

module Octo
  class Product < MassiveRecord::ORM::Table
    include Octo::Record

    belongs_to :enterprise, class_name: 'Octo::Enterprise'

    column_family :info do
      field :id, :integer

      field :price, :integer
      field :name
      field :routeurl

      field :categories, :array
      field :tags, :array

      timestamps
    end

    attr_accessor :id, :price, :name, :routeurl,
      :categories, :tags

  end
end
