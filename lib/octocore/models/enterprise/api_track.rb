require 'massive_record'

module Octo
  class ApiTrack < MassiveRecord::ORM::Table

    field :customid, :uuid
    field :created_at, :timestamp
    field :json_dump
    field :type, index: true

  end
end
