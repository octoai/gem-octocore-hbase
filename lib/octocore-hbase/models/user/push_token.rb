require 'massive_record'

module Octo
  class PushToken < MassiveRecord::ORM::Table

    #belongs_to :user, class_name: 'Octo::User'

    column_family :info do

      field :push_type, :integer
      field :pushtoken

      timestamps
    end

    attr_accessible :push_type, :pushtoken

  end
end

