require 'massive_record'

module Octo
  class UserPhoneDetails < MassiveRecord::ORM::Table

    belongs_to :user, class_name: 'Octo::User'

    field :deviceid
    field :manufacturer
    field :model
    field :os

    timestamps
  end
end

