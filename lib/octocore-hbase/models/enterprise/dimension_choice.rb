require 'massive_record'
require 'octocore-hbase/record'

module Octo

  # Choices for dimensions
  class DimensionChoice < MassiveRecord::ORM::Table

    include Octo::Record

    belongs_to :enterprise, class_name: 'Octo::Enterprise'
    column_family :info do

      field :dimension, :int
      field :choice

      timestamps
    end

  end
end

