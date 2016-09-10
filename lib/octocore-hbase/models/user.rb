require 'massive_record'

module Octo
  class User < MassiveRecord::ORM::Table

    #belongs_to :enterprise, class_name: 'Octo::Enterprise'

    column_family :info do
      field :id, :integer
      timestamps
    end

    attr_accessible :id

    references_many :user_location_histories,
      records_starts_from: :refs_starts_from,
      class_name: 'Octo::UserLocationHistory'

    private

    def refs_starts_from
       "#{self.class.to_s}-#{id}-"
    end

  end
end

