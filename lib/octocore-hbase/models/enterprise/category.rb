require 'massive_record'
require 'octocore-hbase/record'

module Octo
  class Category < MassiveRecord::ORM::Table
    include Octo::Record

    #belongs_to :enterprise, class_name: 'Octo::Enterprise'

    column_family :info do
      field :cat_text
      timestamps
    end

    attr_accessible :cat_text
  end
end
