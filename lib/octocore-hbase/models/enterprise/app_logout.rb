require 'massive_record'

module Octo
  class AppLogout < MassiveRecord::ORM::Table

    belongs_to :enterprise, class_name: 'Octo::Enterprise'

    column_family :info do

      field :created_at, :time
      field :userid, :integer
    end

    attr_accessor :created_at, :userid

  end
end
