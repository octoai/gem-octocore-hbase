require 'massive_record'
require 'octocore/record'

module Octo

  # Stores the data for funnels
  class FunnelData < MassiveRecord::ORM::Table
    include Octo::Record

    belongs_to :enterprise, class_name: 'Octo::Enterprise'

    field :funnel_slug

    field :ts, :time
    field :value, :array

  end
end

