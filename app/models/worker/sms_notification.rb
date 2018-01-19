module Worker
  class SmsNotification

    def process(payload, metadata, delivery_info)
      payload.symbolize_keys!
      puts "asdfasdfsdf"

      puts payload
      
      puts Phonelib.parse(payload[:phone]).national

      
      authy = Authy::API.register_user(:cellphone => Phonelib.parse(payload[:phone]).national, :country_code => "86")

      if authy.ok?
        
        response = Authy::API.request_sms(:id => authy.id)

        if response.ok?
          # sms was sent
          puts "Message Sent Correctly"
        else
          response.errors
          #sms failed to send
        end
      else
        authy.errors # this will return an error hash
      end

      

      # payload.symbolize_keys!
      # raise "TWILIO_NUMBER not set" if ENV['TWILIO_NUMBER'].blank?

      # twilio_client.account.sms.messages.create(
      #   from: ENV["TWILIO_NUMBER"],
      #   to:   Phonelib.parse(payload[:phone]).international,
      #   body: payload[:message]
      # )
      
    end

    # def twilio_client
    #   Twilio::REST::Client.new ENV["TWILIO_SID"], ENV["TWILIO_TOKEN"], ssl_verify_peer: false
    # end

  end
end
