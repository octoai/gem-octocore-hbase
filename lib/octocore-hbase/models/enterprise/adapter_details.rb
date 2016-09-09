require 'massive_record'
require 'octocore-hbase/record'

module Octo
	# Store adapter details of Enterprise
  class AdapterDetails < MassiveRecord::ORM::Table
    include Octo::Record

    belongs_to :enterprise, class_name: 'Octo::Enterprise'

    column_family :info do
      field :adapter_id, :integer
      field :enable, :boolean

      field :settings
    end

    attr_accessible :adapter_id, :enable, :settings

  end
end
