class UsersController < ApplicationController
  before_action :authenticate_user!

  def index 
    @users = User.all
  end

  def show
    @user = User.find(params[:id]) 
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])
 
    respond_to do |format|
	      if @user.save
	        # Tell the UserMailer to send a welcome email after save
	        UserMailer.welcome_email(@user).deliver
	        format.html { redirect_to(@user, notice: 'User was successfully created.') }
	        format.json { render json: @user, status: :created, location: @user }
	      else
	        format.html { render action: 'new' }
	        format.json { render json: @user.errors, status: :unprocessable_entity }
	      end
    	end
    end
end