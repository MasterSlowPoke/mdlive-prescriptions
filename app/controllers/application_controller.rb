class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_time_zone
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  def set_time_zone
    Time.zone = 'Eastern Time (US & Canada)'
  end

  def configure_permitted_parameters
  	puts "configure_permitted_parameters"
  	[:sign_up, :account_update].each do |action|
  		devise_parameter_sanitizer.for(action).push(:name)
  	end
  end
end
