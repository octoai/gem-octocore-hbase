require 'massive_record'

module Octo

  class FunnelObserver < MassiveRecord::ORM::Observer

    def before_create(funnel)
      create_name_slug funnel
      activate_funnel funnel
    end

    def after_create(funnel)
      populate_with_fake_data(funnel)
    end

    private

    # Creates name slug
    def create_name_slug(funnel)
      funnel.name_slug = funnel.name.to_slug
    end

    # Activates a funnel
    def activate_funnel(funnel)
      funnel.active = true
    end


    # Populates a newly created funnel with some fake data
    # @param [Fixnum] days The number of days for which data to be faked
    def populate_with_fake_data(funnel, interval_days = 7)
      if funnel.enterprise.fakedata?
        today = Time.now.beginning_of_day
        (today - interval_days.days).to(today, 24.hour).each do |ts|
          Octo::FunnelData.new(
            enterprise_id: funnel.enterprise_id,
            funnel_slug: funnel.name_slug,
            ts: ts,
            value: fake_data(funnel.funnel.count)
          ).save!
        end
      end
    end


  end
end
