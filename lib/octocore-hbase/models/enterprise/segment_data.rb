require 'massive_record'
require 'octocore-hbase/record'
require 'set'

module Octo

  # The SegmentData class. This class holds data for the segments
  class SegmentData < MassiveRecord::ORM::Table

    include Octo::Record

    belongs_to :enterprise, class_name: 'Octo::Enterprise'

    column_family :info do
      field :segment_slug  # Using field as segment name's slug

      field :ts, :timestamp    # The timestamp at which data is collected
      field :value, :array       # List of values containing data collected
    end

    attr_accessible :segment_slug, :ts, :value

  end
end

