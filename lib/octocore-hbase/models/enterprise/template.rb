require 'massive_record'

module Octo
  class Template < MassiveRecord::ORM::Table
    #belongs_to :enterprise, class_name: 'Octo::Enterprise'

    column_family :info do
      field :category_type

      field :template_text
      field :active, :boolean
      timestamps
    end

    attr_accessible :category_type, :template_text,
      :active
  end
end

