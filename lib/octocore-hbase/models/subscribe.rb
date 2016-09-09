require 'massive_record'

# Model for Subscribe to us (in the footer), on the microsite
module Octo

  class Subscriber < MassiveRecord::ORM::Table

    column_family :info do
      field :created_at, :time
      field :email
    end

    attr_accessor :created_at, :email

  end
end
