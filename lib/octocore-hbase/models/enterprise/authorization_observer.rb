module Octo
  class AuthorizationObserver < MassiveRecord::ORM::Observer

    def before_create(auth)
      Octo.logger.debug "Before create of #{ auth }"
      check_api_field(auth)
      generate_password(auth)
    end

    def after_create(auth)
      kong_requests(auth)
    end

    def after_destroy(auth)
      kong_delete(auth)
    end

    private

    # Check or Generate client apifield
    def check_api_field(auth)
      if(auth.apikey.nil?)
        auth.apikey = SecureRandom.hex
      end
    end

    # Check or Generate client password
    def generate_password(auth)
      if(auth.password.nil?)
        auth.password = Digest::SHA1.hexdigest(auth.username + auth.enterprise_id)
      else
        auth.password = Digest::SHA1.hexdigest(auth.password + auth.enterprise_id)
      end
    end

    # Perform Kong Operations after creating client
    def kong_requests(auth)
      kong_config = Octo.get_config :kong
      if kong_config[:enabled]
        url = '/consumers/'
        payload = {
          username: auth.username,
          custom_id: auth.enterprise_id
        }

        process_kong_request(url, :PUT, payload)
        create_fieldauth( auth.username, auth.apifield)
      end
    end

    # Delete Kong Records
    def kong_delete(auth)
      kong_config = Octo.get_config :kong
      if kong_config[:enabled]
        delete_consumer(auth.username)
      end
    end

  end
end
