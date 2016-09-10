require 'massive_record'
require 'octocore-hbase/record'

module Octo

  class Plan < MassiveRecord::ORM::Table
    include Octo::Record

    column_family :info do

      field :id, :integer
      field :active, :boolean

      field :name
    end

    attr_accessible :id, :active, :name

  end
end

