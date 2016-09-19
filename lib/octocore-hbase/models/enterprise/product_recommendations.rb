require 'massive_record'

module Octo
  class ProductRecommendations < MassiveRecord::ORM::Table

    column_family :info do
      field :userid, :integer
      field :product_id, :integer
      field :version, :integer
      field :created_at, :time

    end

    attr_accessible :userid, :created_at, :product_id, :version
  end
end


