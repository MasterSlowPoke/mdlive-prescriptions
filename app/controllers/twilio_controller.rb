require 'twilio-ruby'

class TwilioController < ApplicationController
  skip_before_action :verify_authenticity_token

  def text
    message = TwilioClient.account.messages.create({
      :from => '+17272286083', 
      :to => '+18132404479', 
      :body => message,
    })

    render plain: message.status
  end
end