require 'massive_record'

module Octo
  class ProductPageView < MassiveRecord::ORM::Table
    belongs_to :enterprise, class_name: 'Octo::Enterprise'
    
    field :userid, :bigint
    field :created_at, :timestamp, order: :desc
    
    field :product_id, :bigint
  end
end
