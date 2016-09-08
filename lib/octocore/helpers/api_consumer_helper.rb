require 'redis'
require 'set'

module Octo
  module Helpers

    # Helper Module for Octo Consumer
    module ApiConsumerHelper

      # Get all the valid events
      # @return [Set<Symbol>] Valid events globally
      def valid_events
        Set.new(Octo.get_config(:allowed_events))
      end

      # Get the API events. These are the ones that the client is billed for
      #   This should eventually be placed under kong helpers when that is
      #   ready.
      # @return [Set<Symbol>] Set of api_events
      # def api_events
      #   Set.new(%w(app.init app.login app.logout page.view productpage.view update.profile))
      # end

      # Handles Kafka messages and perform required operations
      # @param [Hash] msg Hash Message
      def handle(msg)
        msg_obj = Octo::Message::Message.new(msg)
        msg = msg_obj.to_h
        begin
          eventName = msg[:event_name]
          if (valid_events.include?eventName)
            call_hooks(eventName, msg)
          end
        rescue Exception => e  
          puts e.message
          puts e.backtrace.inspect
        end
      end

      # Set Octo callbacks
      # @param [String] event Event name
      # @param [Hash] *args Points to the messsage hash
      def call_hooks(event, *args)
        hook = [:after, event.gsub('.', '_')].join('_').to_sym
        Octo::Callbacks.run_hook(hook, *args)
      end

    end
  end
end

