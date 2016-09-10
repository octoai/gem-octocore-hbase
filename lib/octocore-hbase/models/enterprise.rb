require 'massive_record'

module Octo
  class Enterprise < MassiveRecord::ORM::Table

    # Set ttl of 120 minutes for the caches
    TTL = 120

    default_scope select(:info)

    column_family :info do
      field :id
      field :name
    end

    attr_accessible :id, :name

    references_many :users, records_starts_from: :refs_starts_from,
      class_name: 'Octo::Users'
    references_many :segments, records_starts_from: :refs_starts_from,
      class_name: 'Octo::Segments'
    references_many :templates, records_starts_from: :refs_starts_from,
      class_name: 'Octo::Templates'
    references_many :funnels, records_starts_from: :refs_starts_from,
      class_name: 'Octo::Funnels'


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

  end
end

