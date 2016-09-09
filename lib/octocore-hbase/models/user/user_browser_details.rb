require 'massive_record'

module Octo
  class UserBrowserDetails < MassiveRecord::ORM::Table

    belongs_to :user, class_name: 'Octo::User'

    column_family :info do

      field :cookieid
      field :name
      field :platform
      field :manufacturer

      timestamps
    end

    attr_accessible :cookieid, :name, :platform, :manufacturer

  end
end

