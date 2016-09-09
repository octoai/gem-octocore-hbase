require 'massive_record'

module Octo
  class ApiTrack < MassiveRecord::ORM::Table


    field :customid
    field :created_at, :time
    field :json_dump
    field :type, index: true

  end
end
