require 'massive_record'
require 'octocore/record'

module Octo
  class Tag < MassiveRecord::ORM::Table
    include Octo::Record

    belongs_to :enterprise, class_name: 'Octo::Enterprise'

    field :tag_text
    timestamps
  end
end
