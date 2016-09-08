require 'massive_record'
require 'octocore/trends'

module Octo

  # Class for storing trending category
  class CategoryTrend < MassiveRecord::ORM::Table
    extend Octo::Trends

    belongs_to :enterprise, class_name: 'Octo::Enterprise'

    trendable

    trend_for 'Octo::CategoryHit'
    trend_class 'Octo::Category'
  end
end

