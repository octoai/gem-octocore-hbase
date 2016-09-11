require 'massive_record'

module Octo
  class UserPhoneDetails < MassiveRecord::ORM::Table

    #belongs_to :user, class_name: 'Octo::User'

    column_family :info do

      field :deviceid
      field :manufacturer
      field :model
      field :os

      timestamps
    end

    attr_accessible :deviceid, :manufacturer, :model,
      :os
  end
end

