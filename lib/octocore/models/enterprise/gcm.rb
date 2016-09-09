require 'massive_record'

module Octo

  # Storage for Notifications
  class GcmNotification < MassiveRecord::ORM::Table

    belongs_to :enterprise, class_name: 'Octo::Enterprise'

    field :gcmid, :varchar
    field :userid, :bigint

    field :score, :float
    field :ack, :boolean
    field :sent_at, :timestamp
    field :recieved_at, :timestamp

  end
end

