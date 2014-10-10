class DashboardController < ApplicationController
  before_action :authenticate_user!, only: :calendar

  def index
  	@user = User.new unless current_user
  end

  def calendar
  	@date = Date.today
  end
end
