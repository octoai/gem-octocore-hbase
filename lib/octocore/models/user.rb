require 'massive_record'

module Octo
  class User < MassiveRecord::ORM::Table
    belongs_to :enterprise, class_name: 'Octo::Enterprise'

    field :id, :bigint

    timestamps

    references_many :user_location_histories
  end
end

