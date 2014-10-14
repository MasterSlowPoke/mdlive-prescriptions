class DashboardController < ApplicationController
  before_action :authenticate_user!, only: :calendar

  def index
  	if current_user
  		@todays_doses = current_user.get_days_doses(Date.today)
  	else
  		@user = User.new
  	end
  end

  def calendar
  	@date = params[:month] ? Date.parse(params[:month] + "-1") : Date.today
  end
end
