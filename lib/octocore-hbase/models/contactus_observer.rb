require 'massive_record'

module Octo

  class ContactUsObserver < MassiveRecord::ORM::Observer

    def after_create(contactus)
      send_email contactus
    end


    # Send Email after model save
    def send_email(contactus)

      # Send thankyou mail
      subject = 'Thanks for contacting us - Octo.ai'
    	opts = {
    		text: 'Hey we will get in touch with you shortly. Thanks :)',
    		name: contactus.firstname + ' ' + contactus.lastname
    	}
    	Octo::Email.send(contactus.email, subject, opts)

      # Send mail to aron and param
      Octo.get_config(:email_to).each { |x|
        opts1 = {
            text: contactus.email + ' \n\r ' + contactus.typeofrequest + '\n\r' +  contactus.message,
            name: x.fetch('name')
        }
        Octo::Email.send(x.fetch('email'), subject, opts1)
      }


    end

  end
end
