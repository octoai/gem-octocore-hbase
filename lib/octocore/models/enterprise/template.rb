require 'massive_record'

module Octo
  class Template < MassiveRecord::ORM::Table

    belongs_to :enterprise, class_name: 'Octo::Enterprise'

    field :category_type

    field :template_text
    field :active, :boolean

    timestamps

  end
end

