class RemindersController < ApplicationController
  before_action :set_reminder, only: [:show, :view, :edit, :update, :destroy, :test_mailer_reminder, :test_text_reminder]
  before_action :authenticate_user!

  # GET /reminders
  # GET /reminders.json
  def index
    @reminders = current_user.reminders
  end

  def view
  end

  # GET /reminders/1
  # GET /reminders/1.json
  def show
    @reminder_rule = ReminderRule.new

    respond_to do |format|
      format.html 
      format.ics do 
        stream = render_to_string :show  

        send_data stream, filename: "#{@reminder.title}.ics" 
      end
      format.js 
    end
  end

  # GET /reminders/new
  def new
    @reminder = Reminder.new({}, current_user)
  end

  # GET /reminders/1/edit
  def edit
  end

  # POST /reminders
  # POST /reminders.json
  def create
    if current_user
      @reminder = Reminder.new(reminder_params, current_user)
      respond_to do |format|
        if @reminder.save
          format.html { redirect_to @reminder, notice: 'Reminder was successfully created.' }
          format.json { render :show, status: :created, location: @reminder }
        else
          flash.now[:alert] = 'Reminder was not saved.'
          format.html { render :new }
          format.json { render json: @reminder.errors, status: :unprocessable_entity }
        end
      end
    else
      error_msg = "You must be logged in to create a reminder."
      respond_to do |format|
        format.html { redirect_to root_path, alert: error_msg }
        format.json { render json: {not_authorized: error_msg}, status: :unprocessable_entity }
      end
    end
  end

  def test_mailer_reminder
      @reminder.send_test_email
       redirect_to @reminder, notice: 'test email send'
  end 

def test_text_reminder
      @reminder.send_text
       redirect_to @reminder, notice: 'test text send'
  end 

  # PATCH/PUT /reminders/1
  # PATCH/PUT /reminders/1.json
  def update
    respond_to do |format|
      if @reminder.update(reminder_params)
        format.html { redirect_to @reminder, notice: 'Reminder was successfully updated.' }
        format.json { render :show, status: :ok, location: @reminder }
      else
        flash.now[:alert] = 'Reminder was not saved.'
        format.html { render :edit }
        format.json { render json: @reminder.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reminders/1
  # DELETE /reminders/1.json
  def destroy
    @reminder.reminder_rules.each do |rr|
      rr.destroy
    end
    @reminder.destroy
    respond_to do |format|
      format.html { redirect_to reminders_url, notice: 'Reminder was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reminder
      @reminder = Reminder.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reminder_params
      params.require(:reminder).permit(:title, :num_per, :time_period, :notes, :start, :doses)
    end
end
