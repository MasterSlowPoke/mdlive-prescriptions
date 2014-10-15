class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_time_zone
  before_action :get_current_reminders
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  def set_time_zone
    Time.zone = 'Eastern Time (US & Canada)'
  end

  def get_current_reminders
    if current_user
      @current_doses = current_user.get_current_doses
      @current_count = 0
      @current_doses.each do |time|
        @current_count += time[1].count
      end
    end
  end

  def configure_permitted_parameters
  	puts "configure_permitted_parameters"
  	[:sign_up, :account_update].each do |action|
  		devise_parameter_sanitizer.for(action).push(:name)
  	end
  end
end
