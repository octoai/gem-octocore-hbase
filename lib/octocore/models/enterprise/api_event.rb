require 'massive_record'
require 'octocore/record'

module Octo
  class ApiEvent < MassiveRecord::ORM::Table
    include Octo::Record

    belongs_to :enterprise, class_name: 'Octo::Enterprise'

    field :eventname
  end
end

