require 'massive_record'

module Octo
  class PushToken < MassiveRecord::ORM::Table

    belongs_to :user, class_name: 'Octo::User'

    field :push_type, :bigint
    field :pushtoken

    timestamps
  end
end

