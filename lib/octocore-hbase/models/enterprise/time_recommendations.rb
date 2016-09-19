require 'massive_record'

module Octo
  class TimeRecommendations < MassiveRecord::ORM::Table

    column_family :info do
      field :userid, :integer
      field :next_times, :array
      field :version, :integer
      field :created_at, :time

    end

    attr_accessible :userid, :created_at, :next_times, :version
  end
end

