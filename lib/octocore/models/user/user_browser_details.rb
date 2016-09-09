require 'massive_record'

module Octo
  class UserBrowserDetails < MassiveRecord::ORM::Table

    belongs_to :user, class_name: 'Octo::User'

    field :cookieid
    field :name
    field :platform
    field :manufacturer

    timestamps
  end
end