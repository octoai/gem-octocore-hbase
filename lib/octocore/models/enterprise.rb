require 'massive_record'

module Octo
  class Enterprise < MassiveRecord::ORM::Table

    # Set ttl of 120 minutes for the caches
    TTL = 120

    field :id
    field :name, :varchar

    references_many :users, records_starts_from: :refs_starts_from,
      class_name: 'Octo::Users'
    references_many :segments, records_starts_from: :refs_starts_from,
      class_name: 'Octo::Segments'
    references_many :templates, records_starts_from: :refs_starts_from,
      class_name: 'Octo::Templates'
    references_many :funnels, records_starts_from: :refs_starts_from,
      class_name: 'Octo::Funnels'

    after_save :_setup

    # Setup the new enterprise
    def _setup
      setup_notification_categories
      setup_intelligent_segments
    end

    # Method to check if it is okay to create fakedata for this
    #   client
    # @return [Boolean]
    def fakedata?
      self.name.start_with?('Octo')
    end

    private

    def refs_starts_from
       "#{self.class.to_s}-#{id}-"
    end

    # Setup the notification categories for the enterprise
    def setup_notification_categories
      templates = Octo.get_config(:push_templates)
      if templates
        templates.each do |t|
          args = {
            enterprise_id: self.id,
            category_type: t[:name],
            template_text: t[:text],
            active: true
          }
          Octo::Template.new(args).save!
        end
        Octo.logger.info("Created templates for Enterprise: #{ self.name }")
      end
    end

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

  end

end
