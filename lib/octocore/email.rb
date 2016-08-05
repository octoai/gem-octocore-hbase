require 'mandrill'
require 'resque'
require 'resque-scheduler'

module Octo

  # Octo Email Sender
  module Email

    # Send Emails using mandrill api
    # @param [Text] email Email Address of the receiver
    # @param [Text] subject Subject of Email
    # @param [Hash] opt Hash contain other message details
    def send(email, subject, opts = {})
      if email.nil? or subject.nil?
        raise ArgumentError, 'Email Address or Subject is missing'
      else
        message = {
          from_name: Octo.get_config(:email_sender).fetch(:name),
          from_email: Octo.get_config(:email_sender).fetch(:email),

          subject: subject,

          text: opts.fetch('text', nil),
          html: opts.fetch('html', nil),

          to: [{
            email: email,
            name: opts.fetch('name', nil)
          }]
        }
        # Pass the message to resque only when mandrill key is present
        _mandrill_config = ENV['MANDRILL_API_KEY'] || Octo.get_config(:mandrill_api_key)
        if _mandrill_config and !_mandrill_config.empty?
          enqueue_msg(message)
        end
      end
    end

    # Adding Email details to Resque Queue
    # @param [Hash] message Hash contain message details
    def enqueue_msg(message)
      Resque.enqueue(Octo::EmailSender, message)
    end

  end

  # Class to perform Resque operations for sending email
  class EmailSender

    @queue = :email_sender

    # Resque Perform method
    # @param [Hash] message The details of email
    def self.perform(message)
      _mandrill_config = ENV['MANDRILL_API_KEY'] || Octo.get_config(:mandrill_api_key)
      m = Mandrill::API.new _mandrill_config
      m.messages.send message
    end

  end
end

