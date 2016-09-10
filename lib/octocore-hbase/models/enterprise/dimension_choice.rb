require 'massive_record'
require 'octocore-hbase/record'

module Octo

  # Choices for dimensions
  class DimensionChoice < MassiveRecord::ORM::Table

    include Octo::Record

    #belongs_to :enterprise, class_name: 'Octo::Enterprise'
    column_family :info do

      field :dimension, :integer
      field :choice

      timestamps
    end

    attr_accessible :dimension, :choice

  end
end

