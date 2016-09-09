require 'massive_record'

module Octo
  class Apifield < MassiveRecord::ORM::Table

    field :enterprise_field
    field :enterprise_id, :uuid

  end
end
