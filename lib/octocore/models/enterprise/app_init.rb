require 'massive_record'

module Octo
  class AppInit < MassiveRecord::ORM::Table

    belongs_to :enterprise, class_name: 'Octo::Enterprise'

    field :created_at, :timestamp
    field :userid, :bigint

  end
end
