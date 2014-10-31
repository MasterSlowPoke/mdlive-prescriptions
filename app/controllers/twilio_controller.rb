require 'twilio-ruby'

class TwilioController < ApplicationController
  skip_before_action :verify_authenticity_token

  def text
    sender = params[:From]
    friends = {
      "+18132404479" => "Craig Sniffen"
    }
    name = friends[sender] || "Internet Person"

    twiml = Twilio::TwiML::Response.new do |r|
      r.Message "Hello, #{name}. Thanks for the message."
    end

    render plain: twiml.text
  end
end