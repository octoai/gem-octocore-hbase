require 'massive_record'
require 'octocore/record'

module Octo
	# Store adapter details of Enterprise
  class AdapterDetails < MassiveRecord::ORM::Table
    include Octo::Record

    belongs_to :enterprise, class_name: 'Octo::Enterprise'

    field :adapter_id, :integereger
    field :enable, :boolean
    
    field :settings

  end
end