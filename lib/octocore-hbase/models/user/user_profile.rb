require 'massive_record'

module Octo
  class UserProfileDetails < MassiveRecord::ORM::Table

    belongs_to :user, class_name: 'Octo::User'

    column_family :info do

      field :email
      field :username
      field :dob
      field :gender
      field :alternate_email
      field :mobile
      field :extras

      timestamps
    end

    attr_accessible :email, :username, :dob, :gender, :alternate_email,
      :mobile, :extras
  end
end

