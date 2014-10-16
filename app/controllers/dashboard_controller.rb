class DashboardController < ApplicationController
  before_action :authenticate_user!, only: :calendar

  def index
  	if current_user
  		@todays_doses = current_user.get_days_doses(Date.today)
  	else
  		redirect_to new_user_session_path
  	end
  end

  def calendar
  	@date = params[:month] ? Date.parse(params[:month] + "-1") : Date.today
  end
end
