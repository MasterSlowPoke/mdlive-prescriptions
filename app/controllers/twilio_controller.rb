require 'twilio-ruby'

class TwilioController < ApplicationController
  http_basic_authenticate_with name: "twilio-site", password: Rails.application.secrets.twilio_controller_pass  

  skip_before_action :verify_authenticity_token

  def text
    phone = params[:From]
    phone = phone[-10..-1] if phone # only interested in the 7 digit number and area code
    message = params[:Body] || ""
    
    @user = User.find_by_phone phone

    render_twiml :new_user and return if @user.nil?
    render_twiml :text
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

    def render_twiml(template)
      render "#{template}.xml", content_type: 'application/xml'
    end
end
