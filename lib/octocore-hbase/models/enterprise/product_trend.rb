require 'massive_record'
require 'octocore-hbase/trends'

module Octo

  # Class for storing trending product
  class ProductTrend < MassiveRecord::ORM::Table
    extend Octo::Trends

    #belongs_to :enterprise, class_name: 'Octo::Enterprise'

    trendable

    trend_for 'Octo::ProductHit'
    trend_class 'Octo::Product'
  end
end
