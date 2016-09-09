require 'massive_record'

require 'octocore-hbase/counter'
require 'octocore-hbase/trendable'
require 'octocore-hbase/schedeuleable'

module Octo
  class ApiHit < MassiveRecord::ORM::Table

    extend Octo::Counter
    extend Octo::Scheduleable

    COUNTERS = 30

    belongs_to :enterprise, class_name: 'Octo::Enterprise'

    countables

  end
end
