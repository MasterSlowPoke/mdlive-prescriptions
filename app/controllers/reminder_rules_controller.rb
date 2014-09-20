class ReminderRulesController < ApplicationController
  before_action :set_reminder_rule, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /reminder_rules
  # GET /reminder_rules.json
  def index
    @reminder_rules = ReminderRule.all
  end

  # GET /reminder_rules/1
  # GET /reminder_rules/1.json
  def show
  end

  # GET /reminder_rules/new
  def new
    @reminder_rule = ReminderRule.new
  end

  # GET /reminder_rules/1/edit
  def edit
  end

  # POST /reminder_rules
  # POST /reminder_rules.json
  def create
    respond_to do |format|
      if @reminder_rule = ReminderRule.new(reminder_rule_params)
        # This should be able to be ran from anywhere in the application
        UserMailer.reminder_email(current_user, @reminder_rule.reminder).deliver
        format.html { redirect_to @reminder_rule.reminder, notice: 'Reminder rule was successfully created.' }
        format.json { render :show, status: :created, location: @reminder_rule }
      else
        format.html { render :new }
        format.json { render json: @reminder_rule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reminder_rules/1
  # PATCH/PUT /reminder_rules/1.json
  def update
    respond_to do |format|
      if @reminder_rule.update(reminder_rule_params)
        format.html { redirect_to @reminder_rule.reminder, notice: 'Reminder rule was successfully updated.' }
        format.json { render :show, status: :ok, location: @reminder_rule }
      else
        format.html { render :edit }
        format.json { render json: @reminder_rule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reminder_rules/1
  # DELETE /reminder_rules/1.json
  def destroy
    reminder = @reminder_rule.reminder
    @reminder_rule.destroy
    reminder.assign_counts
    respond_to do |format|
      format.html { redirect_to reminder, notice: 'Reminder rule was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reminder_rule
      @reminder_rule = ReminderRule.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reminder_rule_params
      params.require(:reminder_rule).permit(:day_of_week, :time_of_day, :reminder_id)
    end
end
