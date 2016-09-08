require 'massive_record'

module Octo
  class ApiKey < MassiveRecord::ORM::Table


    field :enterprise_key
    field :enterprise_id

  end
end
