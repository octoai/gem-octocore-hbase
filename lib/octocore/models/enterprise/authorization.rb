require 'massive_record'
require 'securerandom'
require 'octocore/helpers/kong_helper'

module Octo
  class Authorization < MassiveRecord::ORM::Table
    include Octo::Helpers::KongHelper

    field :username

    field :enterprise_id
    field :email
    field :apifield
    field :session_token
    field :custom_id
    field :password
    field :admin, :boolean

    before_create :check_api_field, :generate_password
    after_create :kong_requests

    after_destroy :kong_delete

    timestamps

    # Check or Generate client apifield
    def check_api_field
      if(self.apifield.nil?)
        self.apifield = SecureRandom.hex
      end
    end

    # Check or Generate client password
    def generate_password
      if(self.password.nil?)
        self.password = Digest::SHA1.hexdigest(self.username + self.enterprise_id)
      else
        self.password = Digest::SHA1.hexdigest(self.password + self.enterprise_id)
      end
    end

    # Perform Kong Operations after creating client
    def kong_requests
      kong_config = Octo.get_config :kong
      if kong_config[:enabled]
        url = '/consumers/'
        payload = {
          username: self.username,
          custom_id: self.enterprise_id
        }

        process_kong_request(url, :PUT, payload)
        create_fieldauth( self.username, self.apifield)
      end
    end

    # Delete Kong Records
    def kong_delete
      kong_config = Octo.get_config :kong
      if kong_config[:enabled]
        delete_consumer(self.username)
      end
    end

  end
end
