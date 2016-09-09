require 'massive_record'
require 'octocore/record'
require 'set'

module Octo

  # The segment class. Responsible for segments
  class Segment < MassiveRecord::ORM::Table
    include Octo::Record

    belongs_to :enterprise, class_name: 'Octo::Enterprise'

    field :name_slug       # Name slug as field
    field :active, :boolean       # Active or Not

    field :integerelligence, :boolean # If it is Octo's intelligent segment or manual

    field :name         # Name of the segment
    field :type, :integer          # Type of segment
    field :event_type   # Event Type used for events segmentation

    list :dimensions, :integer      # list storing dimensions used
    list :operators, :integer       # list storing operators on dimensions
    list :dim_operators, :integer   # list storing operators between dimensions
    list :values         # list of values for operations on dimensions

    timestamps                  # The usual housekeeping thing

    before_create :create_name_slug, :activate

    # Creates name slug
    def create_name_slug
      self.name_slug = self.name.to_slug
    end

    def activate
      self.active = true
    end

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

