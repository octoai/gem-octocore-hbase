require 'massive_record'
require 'securerandom'

# Model for contact us page on the microsite
module Octo
  class UserTime < MassiveRecord::ORM::Table

    # Any event that happens within this TIME_WINDOW
    # will be treated as one event
    TIME_WINDOW = 10.minutes

    column_family :info do
      field :enterpriseid
      field :userid
      field :created_at, :time
    end

    attr_accessible :enterpriseid, :userid, :created_at

    def default_id
      next_id
    end

    def next_id(options = {})
      SecureRandom.uuid
    end

  end
end


