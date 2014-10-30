class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin, only: [:index]

  def index 
    @users = User.all
  end

  def show
    @user = current_user

    respond_to do |format|
      format.html
      format.ics {
        stream = render_to_string :show  

        send_data stream, filename: "Reminders For #{current_user.name}.ics" 
      }
    end
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

  private
    def require_admin
      unless current_user.admin 
        redirect_to root_path, notice: 'You are not authorized to view this content.'
      end
    end
end