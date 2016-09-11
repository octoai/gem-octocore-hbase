require 'massive_record'

module Octo
  class UserLocationHistory < MassiveRecord::ORM::Table

    #belongs_to :user, class_name: 'Octo::User'

    column_family :info do

      field :created_at, :time

      field :latitude, :integer
      field :longitude, :integer
    end

    attr_accessible :created_at, :latitude, :longitude
  end
end

