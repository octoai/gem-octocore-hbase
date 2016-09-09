require 'massive_record'

require 'octocore/counter'
require 'octocore/trendable'
require 'octocore/schedeuleable'

module Octo

  class CategoryHit < MassiveRecord::ORM::Table
    extend Octo::Counter
    extend Octo::Trendable
    extend Octo::Scheduleable

    COUNTERS = 20

    belongs_to :enterprise, class_name: 'Octo::Enterprise'

    countables
    trendables

    baseline 'Octo::CategoryBaseline'
    trends_class 'Octo::CategoryTrend'

  end
end
