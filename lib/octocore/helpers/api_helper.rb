require 'securerandom'
require 'octocore'
require 'octocore/stats'

module Octo
  module Helpers
    module ApiHelper

      include Octo::Stats

      KONG_HEADERS = %w(HTTP_X_CONSUMER_ID HTTP_X_CONSUMER_CUSTOM_ID HTTP_X_CONSUMER_USERNAME)

      # Get enterprise details from the HTTP headers that Kong sets
      # @return [Hash] The hash of enterprise details
      def enterprise_details
        kong_config = Octo.get_config :kong
        if kong_config[:enabled]
          KONG_HEADERS.inject({}) do |r, header|
            key = header.gsub('HTTP_X_CONSUMER_', '').downcase
            r[key] = request.env.fetch(header, nil)
            r
          end
        else
          apikey = request.env.fetch('HTTP_APIKEY')
          {custom_id: settings.redis.get(apikey)}
        end
      end

      # Gets the POSTed parameters from rack env
      # @return [Hash] A hash of POSTed parameters
      def post_params
        instrument(:json_parse) do
         JSON.parse(request.env['rack.input'].read)
        end
      end

      # Generate a UUID for each response
      # @return [String] UUID
      def uuid
        SecureRandom.uuid
      end

      # Process an incoming request
      # @param [String] event_name The name of the event
      # @return [JSON] The json return value after processing
      def process_request(event_name)
        postparams = post_params
        opts = {
          event_name: event_name,
          enterprise: enterprise_details,
          uuid: uuid
        }
        postparams.merge!(opts)
        kafka_config = Octo.get_config :kafka
        if kafka_config[:enabled]
          settings.kafka_bridge.push(postparams)
        else
          settings.queue.push(JSON.dump(postparams))
        end
        { eventId: opts[:uuid] }.to_json
      end

    end
  end
end
