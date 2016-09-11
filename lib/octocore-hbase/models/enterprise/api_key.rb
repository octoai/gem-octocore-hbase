require 'massive_record'

module Octo
  class ApiKey < MassiveRecord::ORM::Table


    column_family :info do
      field :enterprise_key
      field :enterprise_id
    end

    attr_accessible :enterprise_key, :enterprise_id

  end
end
