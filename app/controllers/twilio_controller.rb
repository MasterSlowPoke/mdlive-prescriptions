require 'twilio-ruby'

class TwilioController < ApplicationController
  http_basic_authenticate_with name: "twilio-site", password: Rails.application.secrets.twilio_controller_pass  

  skip_before_action :verify_authenticity_token

  def text
    session["counter"] ||= 0
    sms_count = session["counter"]

    sender = params[:From]
    friends = {
      "+18132404479" => "Craig Sniffen"
    }
    name = friends[sender] || "Internet Person"

    twiml = Twilio::TwiML::Response.new do |r|
      r.Message "Hello, #{name}. You just texted me #{sms_count + 1} times! Your message was '#{params[:Body]}'"
    end

    session["counter"] += 1

    render xml: twiml.text
  end

  def send_text
    phone = "+18132404479"
    message = "Text messaging!"

    TwilioClient.account.messages.create({
      :from => '+17272286083', 
      :to => phone, 
      :body => message,
    })

    render plain: "Text message sent."
  end

  private
    STOP_MESSAGES = ['STOP', 'STOPALL', 'UNSUBSCRIBE', 'CANCEL', 'END', 'QUIT']

    START_MESSAGES = ['START', 'YES']
end
