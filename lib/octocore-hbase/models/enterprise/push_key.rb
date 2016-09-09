require 'massive_record'

module Octo
  class Pushfield < MassiveRecord::ORM::Table
    belongs_to :enterprise, class_name: 'Octo::Enterprise'

    column_family :info do
      field :push_type, :integer
      field :field

      timestamps
    end
  end
end

