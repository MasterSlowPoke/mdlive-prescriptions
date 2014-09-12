class ReminderItemsController < ApplicationController
  before_action :set_reminder_item, only: [:show, :edit, :update, :destroy]

  # GET /reminder_items
  # GET /reminder_items.json
  def index
    @reminder_items = ReminderItem.all
  end

  # GET /reminder_items/1
  # GET /reminder_items/1.json
  def show
  end

  # GET /reminder_items/new
  def new
    @reminder_item = ReminderItem.new
  end

  # GET /reminder_items/1/edit
  def edit
  end

  # POST /reminder_items
  # POST /reminder_items.json
  def create
    @reminder_item = ReminderItem.new(reminder_item_params)

    respond_to do |format|
      if @reminder_item.save
        # This should be able to be ran from anywhere in the application
        UserMailer.reminder_email(current_user).deliver
        format.html { redirect_to @reminder_item, notice: 'Reminder item was successfully created.' }
        format.json { render :show, status: :created, location: @reminder_item }
      else
        format.html { render :new }
        format.json { render json: @reminder_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reminder_items/1
  # PATCH/PUT /reminder_items/1.json
  def update
    respond_to do |format|
      if @reminder_item.update(reminder_item_params)
        format.html { redirect_to @reminder_item, notice: 'Reminder item was successfully updated.' }
        format.json { render :show, status: :ok, location: @reminder_item }
      else
        format.html { render :edit }
        format.json { render json: @reminder_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reminder_items/1
  # DELETE /reminder_items/1.json
  def destroy
    @reminder_item.destroy
    respond_to do |format|
      format.html { redirect_to reminder_items_url, notice: 'Reminder item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reminder_item
      @reminder_item = ReminderItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reminder_item_params
      params.require(:reminder_item).permit(:day_of_week, :time_of_day, :reminder_id)
    end
end
