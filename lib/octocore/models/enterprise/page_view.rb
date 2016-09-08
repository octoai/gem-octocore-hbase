require 'massive_record'

module Octo
  class PageView < MassiveRecord::ORM::Table
    belongs_to :enterprise, class_name: 'Octo::Enterprise'

    field :userid,     :integer
    field :created_at, :time, order: :desc

    field :routeurl
  end
end
