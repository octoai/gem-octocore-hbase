require 'massive_record'

module Octo

  # Storage for Notifications
  class GcmNotification < MassiveRecord::ORM::Table

    belongs_to :enterprise, class_name: 'Octo::Enterprise'

    field :gcmid
    field :userid, :integer

    field :score, :integer
    field :ack, :boolean
    field :sent_at, :time
    field :recieved_at, :time

  end
end

