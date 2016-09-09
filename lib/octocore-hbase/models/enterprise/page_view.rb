require 'massive_record'

module Octo
  class PageView < MassiveRecord::ORM::Table
    belongs_to :enterprise, class_name: 'Octo::Enterprise'

    column_family :info do

      field :userid,     :integer
      field :created_at, :time, order: :desc

      field :routeurl
    end

    attr_accessor :userid, :created_at, :routeurl
  end
end
