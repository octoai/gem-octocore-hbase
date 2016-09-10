require 'massive_record'
require 'octocore-hbase/record'

module Octo
  class Tag < MassiveRecord::ORM::Table
    include Octo::Record

    #belongs_to :enterprise, class_name: 'Octo::Enterprise'

    column_family :info do
      field :tag_text
      timestamps
    end

    attr_accessible :tag_text

  end
end
