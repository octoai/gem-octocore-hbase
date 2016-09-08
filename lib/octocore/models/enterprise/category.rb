require 'massive_record'
require 'octocore/record'

module Octo
  class Category < MassiveRecord::ORM::Table
    include Octo::Record

    belongs_to :enterprise, class_name: 'Octo::Enterprise'

    field :cat_text
    timestamps
  end
end
