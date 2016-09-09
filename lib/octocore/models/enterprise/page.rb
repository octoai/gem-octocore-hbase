require 'massive_record'

module Octo
  class Page < MassiveRecord::ORM::Table

    belongs_to :enterprise, class_name: 'Octo::Enterprise'

    field :routeurl

    set :categories
    set :tags
  end
end

