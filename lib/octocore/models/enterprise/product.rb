require 'massive_record'
require 'octocore/record'

module Octo
  class Product < MassiveRecord::ORM::Table
    include Octo::Record

    belongs_to :enterprise, class_name: 'Octo::Enterprise'

    field :id, :integer

    field :price, :integer
    field :name
    field :routeurl

    field :categories, :array
    field :tags, :array

    timestamps
  end
end
