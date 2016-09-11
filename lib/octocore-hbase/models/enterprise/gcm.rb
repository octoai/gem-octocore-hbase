require 'massive_record'

module Octo

  # Storage for Notifications
  class GcmNotification < MassiveRecord::ORM::Table

    #belongs_to :enterprise, class_name: 'Octo::Enterprise'

    column_family :info do

      field :gcmid
      field :userid, :integer

      field :score, :integer
      field :ack, :boolean
      field :sent_at, :time
      field :recieved_at, :time

    end

    attr_accessible :gcmid, :userid, :score, :ack, :sent_at,
      :recieved_at
  end
end

