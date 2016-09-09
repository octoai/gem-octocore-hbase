require 'massive_record'
require 'octocore/record'

module Octo
  class Product < MassiveRecord::ORM::Table
    include Octo::Record

    belongs_to :enterprise, class_name: 'Octo::Enterprise'

    field :id, :bigint

    field :price, :float
    field :name
    field :routeurl

    set :categories
    set :tags

    timestamps
  end
end
