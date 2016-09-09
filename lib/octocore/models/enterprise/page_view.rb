require 'massive_record'

module Octo
  class PageView < MassiveRecord::ORM::Table

    belongs_to :enterprise, class_name: 'Octo::Enterprise'

    field :userid,     :bigint
    field :created_at, :timestamp, order: :desc

    field :routeurl
  end
end
