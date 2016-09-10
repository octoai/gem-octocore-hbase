require 'massive_record'
require 'octocore-hbase/record'

module Octo
  class ApiEvent < MassiveRecord::ORM::Table
    include Octo::Record

    #belongs_to :enterprise, class_name: 'Octo::Enterprise'

    column_family :info do
      field :eventname
    end

    attr_accessible :eventname

  end
end

