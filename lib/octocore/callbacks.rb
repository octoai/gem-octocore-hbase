require 'hooks'
require 'active_support/concern'

module Octo

  # Central Hooks Module
  module OctoHooks

    extend ActiveSupport::Concern

    included do

      define_hooks :after_app_init, :after_app_login, :after_app_logout,
                   :after_page_view, :after_productpage_view, :after_connect,
                   :after_update_profile, :after_update_push_token, :after_funnel_update

      # # Define the after_app_init hook
      # after_app_init do |args|
      #   update_counters args
      # end

      # # Define the after_app_login hook
      # after_app_login do |args|
      #   update_counters args
      # end

      # # Define the after_app_logout hook
      # after_app_logout do |args|
      #   update_counters args
      # end

      # # Define the after_page_view hook
      # after_page_view do |args|
      #   add_session args
      #   update_counters args
      # end

      # # Define the after_productpage_view hook
      # after_productpage_view do |args|
      #   add_session args
      #   update_counters args
      # end


    end

    # Add all the post-hook-call methods here. Also, extend the module
    #   from here.
    module ClassMethods

      # Updates the counters of various types depending
      #   on the event.
      # @param [Hash] opts The options hash
      def update_counters(opts)
        if opts.has_key?(:product)
          Octo::ProductHit.increment_for(opts[:product])
        end
        if opts.has_key?(:categories)
          opts[:categories].each do |cat|
            Octo::CategoryHit.increment_for(cat)
          end
        end
        if opts.has_key?(:tags)
          opts[:tags].each do |tag|
            Octo::TagHit.increment_for(tag)
          end
        end
        if opts.has_key?(:event)
          Octo::ApiHit.increment_for(opts[:event])
        end
      end
      # Adds user session for page_view and
      # product_page_view to redis.
      # It self expires in n seconds from last hit
      def add_session(opts)
        if Octo.is_not_flagged?(Octo::Funnel)
          if opts.has_key?(:type)
            createRedisShadowKey(opts[:enterprise].id.to_s + '_' + opts[:user].id.to_s,
                                 opts[:type].to_s,
                                 Octo.get_config(:session_length))
          end
        end
      end

      # Method was created because when a redis key
      #  expires you can just catch the key name,
      #  and not its value. So what we do is
      #  create a shadow key for the given key name
      #  and make it expire in the given amt of
      #  time (seconds).
      # This helps us in catching the event
      #  when the (shadow) key expires, after which we
      #  read the value of the main key and later
      #  delete the main key
      # You can change it from rpush to lpush, or set
      #  whichever you want to use.
      def createRedisShadowKey(keyname, value, duration)
        Cequel::Record.redis.setex("shadow:" + keyname,duration,"")
        Cequel::Record.redis.rpush(keyname, value)
      end
    end
  end

  # The class responsible for handling callbacks.
  #   You must never need to make changes here
  class Callbacks
    include Hooks
    include Octo::OctoHooks

    class << self
      def callback_update(msg)
        update_counters msg
      end
    end

  end
end
