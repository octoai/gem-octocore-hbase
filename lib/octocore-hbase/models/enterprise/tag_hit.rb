require 'massive_record'

require 'octocore-hbase/counter'
require 'octocore-hbase/trendable'
require 'octocore-hbase/schedeuleable'

module Octo

  class TagHit < MassiveRecord::ORM::Table
    extend Octo::Counter
    extend Octo::Trendable
    extend Octo::Scheduleable

    COUNTERS = 20

    #belongs_to :enterprise, class_name: 'Octo::Enterprise'

    countables
    trendables

    baseline 'Octo::TagBaseline'
    trends_class 'Octo::TagTrend'

  end
end
