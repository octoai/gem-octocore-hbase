require 'massive_record'

module Octo

  class SegmentObserver < MassiveRecord::ORM::Observer

    def before_create(seg)
      create_name_slug(seg)
      activate(seg)
    end


    private

    # Creates name slug
    def create_name_slug(seg)
      seg.name_slug = seg.name.to_slug
    end

    def activate
      seg.active = true
    end

  end
end
