require 'massive_record'

module Octo
  class Page < MassiveRecord::ORM::Table
    #belongs_to :enterprise, class_name: 'Octo::Enterprise'

    column_family :info do
      field :routeurl

      field :categories, :array
      field :tags, :array
    end

    attr_accessible :routeurl, :categories, :tags
  end
end

