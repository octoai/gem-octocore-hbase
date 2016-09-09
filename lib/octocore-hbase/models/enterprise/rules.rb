require 'massive_record'
require 'octocore-hbase/record'

module Octo
  class Rules < MassiveRecord::ORM::Table
    include Octo::Record

    # Types of conversions
    DAILY               = 0
    WEEKLY              = 1
    WEEKENDS            = 2
    ALTERNATE           = 3

    belongs_to :enterprise, class_name: 'Octo::Enterprise'

    column_family :info do
      field :name_slug       # Name slug as rule
      field :active, :boolean       # Active or Not

      field :name         # Name of the rule
      field :segment      # slug name of segment
      field :template_cat
      field :duration, :int     # Daily, weekly, weekends ,alternate days
      field :start_time, :time
      field :end_time, :time

      timestamps
    end

    attr_accessible :name_slug, :active, :name, :segment,
      :template_cat, :duration, :start_time, :end_time

    class << self

      # Fetches the types of durations
      # @return [Hash] The name and its duration value
      def duration_types
        {
          Octo::Rules::DAILY => 'Daily',
          Octo::Rules::WEEKLY => 'Weekly',
          Octo::Rules::WEEKENDS => 'Weekends',
          Octo::Rules::ALTERNATE => 'Alternate Days'
        }
      end
    end

  end
end

