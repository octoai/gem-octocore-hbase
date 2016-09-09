require 'massive_record'

module Octo
  class ProductPageView < MassiveRecord::ORM::Table
    belongs_to :enterprise, class_name: 'Octo::Enterprise'

    column_family :info do
      field :userid, :integer
      field :created_at, :time, order: :desc

      field :product_id, :integer
    end
  end
end
