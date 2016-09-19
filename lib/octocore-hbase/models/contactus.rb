require 'massive_record'

# Model for contact us page on the microsite
module Octo
  class ContactUs < MassiveRecord::ORM::Table

    column_family :info do
      field :email
      field :created_at, :time

      field :typeofrequest
      field :firstname
      field :lastname
      field :message
    end

    attr_accessible :email, :created_at, :typeofrequest, :firstname,
      :lastname, :message

    def default_id
      next_id
    end

    def next_id(options = {})
    end

  end
end

