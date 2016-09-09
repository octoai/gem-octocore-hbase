require 'massive_record'

# Model for contact us page on the microsite
module Octo
  class ContactUs < MassiveRecord::ORM::Table

    field :email
    field :created_at, :timestamp

    field :typeofrequest
    field :firstname
    field :lastname
    field :message

    after_create :send_email

    # Send Email after model save
    def send_email

      # Send thankyou mail
      subject = 'Thanks for contacting us - Octo.ai'
    	opts = {
    		text: 'Hey we will get in touch with you shortly. Thanks :)',
    		name: self.firstname + ' ' + self.lastname
    	}
    	Octo::Email.send(self.email, subject, opts)

      # Send mail to aron and param
      Octo.get_config(:email_to).each { |x|
        opts1 = {
            text: self.email + ' \n\r ' + self.typeofrequest + '\n\r' +  self.message,
            name: x.fetch('name')
        }
        Octo::Email.send(x.fetch('email'), subject, opts1)
      }


    end

  end
end