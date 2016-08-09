require 'json'

module Octo
  # Message abstraction module 
  module Message

    # Parsing kafka messages for octo consumer
    module MessageParser
    
      # Parsing Message hash in Octo compatible form
      # @param [Hash] Message Hash
      # @return [Hash] Hash in Octo form
      def parse(msg)
        msg = JSON.parse(msg)
        m = { event_name: msg['event_name'] }
        case msg['event_name']
        when 'funnel_update'
          m.merge!({
                    rediskey: msg['rediskey']
                  })
        when 'update.profile'
          m.merge!({
                    profileDetails: msg['profileDetails']
                  })
        when 'page.view'
          m.merge!({
                    routeUrl:     msg['routeUrl'],
                    categories:   msg.fetch('categories', []),
                    tags:         msg.fetch('tags', [])
                  })
        when 'productpage.view'
          m.merge!({
                    routeUrl:     msg['routeUrl'],
                    categories:   msg.fetch('categories', []),
                    tags:         msg.fetch('tags', []),
                    productId:    msg['productId'],
                    productName:  msg['productName'],
                    price:        msg['price']
                  })
        when 'update.push_token'
          m.merge!({
                    pushType:     msg['notificationType'],
                    pushKey:      msg['pushKey'],
                    pushToken:    msg['pushToken']
                  })
        end
        enterprise = msg['enterprise']
        raise StandardError, 'Parse Error' if enterprise.nil?

        eid = if enterprise.has_key?'custom_id'
                enterprise['custom_id']
              elsif enterprise.has_key?'customId'
                enterprise['customId']
              end

        ename = if enterprise.has_key?'user_name'
                  enterprise['user_name']
                elsif enterprise.has_key?'userName'
                  enterprise['userName']
                else
                  nil
                end
        m.merge!({
          id:             msg.fetch('uuid', nil),
          enterpriseId:   eid,
          enterpriseName: ename,
          phone:          msg.fetch('phoneDetails', nil),
          browser:        msg.fetch('browserDetails', nil),
          userId:         msg.fetch('userId', -1),
          created_at:     Time.now
        })

        m
      end

    end

    # To handle message abstraction
    class Message
      include MessageParser

      attr_reader :message
      
      # Converting Message hash in Octo compatible form
      # @param [Hash] Message Hash
      def initialize(msg)
        @message = msg
      end

      # To get hash message
      # @return [Hash] Message Hash
      def to_h
        parse(@message)
      end

      # To get enterprise id
      # @return [String] Enterprise Id
      def eid
        msg = to_json
        enterprise = msg['enterprise']
        raise StandardError, 'Parse Error' if enterprise.nil?

        eid = if enterprise.has_key?'custom_id'
                enterprise['custom_id']
              elsif enterprise.has_key?'customId'
                enterprise['customId']
              end

        eid
      end
      
    end
  end
end