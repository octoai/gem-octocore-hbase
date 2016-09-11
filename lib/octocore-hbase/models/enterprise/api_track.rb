require 'massive_record'

module Octo
  class ApiTrack < MassiveRecord::ORM::Table

    column_family :info do

      field :customid
      field :created_at, :time
      field :json_dump
      field :type

    end

    attr_accessible :customid, :created_at, :json_dump,
      :type
  end
end
