require 'massive_record'

module Octo

  class EnterpriseObserver < MassiveRecord::ORM::Observer

    def after_save(enterprise)
      setup_notification_categories enterprise
      setup_intelligent_segments enterprise
    end

    private

    # Setup the intelligent segments for the enterprise
    def setup_intelligent_segments
      segments = Octo.get_config(:intelligent_segments)
      if segments
        segments.each do |seg|
          args = {
            enterprise_id: self.id,
            name: seg[:name],
            type: seg[:type].constantize,
            dimensions: seg[:dimensions].collect(&:constantize),
            operators: seg[:operators].collect(&:constantize),
            values: seg[:values].collect(&:constantize),
            active: true,
            intelligence: true,
          }
          Octo::Segment.new(args).save!
        end
        Octo.logger.info "Created segents for Enterprise: #{ self.name }"
      end
    end


    # Setup the notification categories for the enterprise
    def setup_notification_categories(enterprise)
      templates = Octo.get_config(:push_templates)
      if templates
        templates.each do |t|
          args = {
            enterprise_id: enterprise.id,
            category_type: t[:name],
            template_text: t[:text],
            active: true
          }
          Octo::Template.new(args).save!
        end
        Octo.logger.info("Created templates for Enterprise: #{ self.name }")
      end
    end

  end
end
