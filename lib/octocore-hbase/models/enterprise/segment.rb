require 'massive_record'
require 'octocore-hbase/record'
require 'set'

module Octo

  # The segment class. Responsible for segments
  class Segment < MassiveRecord::ORM::Table
    include Octo::Record

    #belongs_to :enterprise, class_name: 'Octo::Enterprise'

    column_family :info do
      field :name_slug       # Name slug as field
      field :active, :boolean       # Active or Not

      field :intelligence, :boolean # If it is Octo's intelligent segment or manual

      field :name         # Name of the segment
      field :type, :integer          # Type of segment
      field :event_type   # Event Type used for events segmentation

      field :dimensions, :array      # list storing dimensions used
      field :operators, :array       # list storing operators on dimensions
      field :dim_operators, :array   # list storing operators between dimensions
      field :values, :array         # list of values for operations on dimensions

      timestamps                  # The usual housekeeping thing
    end

    attr_accessible :name_slug, :active, :intelligence,
      :name, :type, :event_type, :dimensions, :operators,
      :dim_operators, :values


    def data(ts = Time.now.floor)
      args = {
        enterprise_id: self.enterprise.id,
        segment_slug: self.name_slug,
        ts: ts
      }
      res = Octo::SegmentData.where(args)
      if res.count > 0
        res.first
      elsif self.enterprise.fakedata?
        # populate a poser data
        val = [rand(1000..10000), rand(0.0..70.0)]
        args.merge!({ value: val })
        Octo::SegmentData.new(args).save!
      end
    end

    def self.find_by_enterprise_and_name(enterprise, name)
      where({enterprise_id: enterprise.id, name_slug: name.to_slug})
    end


  end
end

