require 'massive_record'

module Octo
  class Pushfield < MassiveRecord::ORM::Table
    belongs_to :enterprise, class_name: 'Octo::Enterprise'

    field :push_type, :integer
    field :field

    timestamps
  end
end

