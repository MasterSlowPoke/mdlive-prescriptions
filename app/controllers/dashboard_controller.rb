class DashboardController < ApplicationController
  before_action :authenticate_user!, only: :calendar

  def index
  end

  def calendar
  end
end
