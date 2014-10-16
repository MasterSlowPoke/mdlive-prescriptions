class DashboardController < ApplicationController
  before_action :authenticate_user!, only: :calendar

  def index
  	if current_user
  		@todays_doses = current_user.get_days_doses(Date.today)
  	else
  		redirect_to new_user_session_path
  	end
  end

  def pitch 
    current_user.send_reminders(Date.today.beginning_of_day, Date.today.end_of_day) if current_user
    redirect_to root_path
  end

  def calendar
  	@date = params[:month] ? Date.parse(params[:month] + "-1") : Date.today
  end
end
