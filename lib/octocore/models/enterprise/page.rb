require 'massive_record'

module Octo
  class Page < MassiveRecord::ORM::Table
    belongs_to :enterprise, class_name: 'Octo::Enterprise'

    field :routeurl

    field :categories, :array
    field :tags, :array
  end
end

