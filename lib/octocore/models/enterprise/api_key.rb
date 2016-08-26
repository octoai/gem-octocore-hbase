require 'cequel'

module Octo
  class ApiKey
    include Cequel::Record

    key :enterprise_key, :text
    key :enterprise_id, :uuid

  end
end
