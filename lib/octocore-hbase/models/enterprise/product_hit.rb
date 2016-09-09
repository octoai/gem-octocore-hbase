require 'massive_record'

require 'octocore-hbase/counter'
require 'octocore-hbase/trendable'
require 'octocore-hbase/schedeuleable'

module Octo

  class ProductHit < MassiveRecord::ORM::Table
    extend Octo::Counter
    extend Octo::Trendable
    extend Octo::Scheduleable

    COUNTERS = 30

    belongs_to :enterprise, class_name: 'Octo::Enterprise'

    countables
    trendables

    baseline 'Octo::ProductBaseline'
    trends_class 'Octo::ProductTrend'

  end
end
