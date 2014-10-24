class ReminderRulesController < ApplicationController
  before_action :set_reminder_rule
  before_action :authenticate_user!

  # GET /reminder_rules/1
  # GET /reminder_rules/1.js
  def show
  end

  # GET /reminder_rules/1/edit
  def edit
  end

  # PATCH/PUT /reminder_rules/1
  # PATCH/PUT /reminder_rules/1.json
  def update
    respond_to do |format|
      if @reminder_rule.update(reminder_rule_params)
        CountAllocator.new(@reminder_rule.reminder).allocate!
        format.html { redirect_to @reminder_rule.reminder, notice: 'Notification was updated successfully.' }
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
    CountAllocator.new(reminder).allocate!

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
      params.require(:reminder_rule).permit(:day_of_week, :time_of_day, :emailable, :textable, :reminder_id)
    end
end
