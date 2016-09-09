require 'massive_record'
require 'octocore/record'

module Octo

  # Choices for dimensions
  class DimensionChoice
 < MassiveRecord::ORM::Table
    include Octo::Record

    belongs_to :enterprise, class_name: 'Octo::Enterprise'

    field :dimension, :integer
    field :choice

    timestamps

  end
end

