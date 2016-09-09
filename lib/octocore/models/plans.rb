require 'massive_record'
require 'octocore/record'

module Octo

  class Plan
 < MassiveRecord::ORM::Table
    include Octo::Record

    field :id, :integer
    field :active, :boolean

    field :name
  end
end

