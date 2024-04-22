class EventsController < ApplicationController
  before_action :set_event, only: [:edit, :update, :destroy]

  def check_geocode_error
    puts errors.full_messages.to_sentence
  end

  def index
    @events = Event.where.not(host_id: current_user.id)
    @events = @events.where.not(id: current_user.reservations.select(:event_id))
    # Filter by date
    if params[:date].present?
      @events = @events.where("DATE(date_time) = ?", Date.parse(params[:date]))
    end
    # Filter by location
    if params[:location].present?
      @events = @events.where("location LIKE ?", "%#{params[:location]}%")
    end

    # Filter by capacity
    if params[:capacity].present?
      @events = @events.where("capacity >= ?", params[:capacity].to_i)
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  def my_events
    @hosted_events = current_user.hosted_events.order(date_time: :asc)
    @reserved_events = current_user.reserved_events.order(date_time: :asc)
  end

  def new
    @event = Event.new
    @games = Game.all.order(:title)
    @event.game_id = params[:game_id] if params[:game_id].present?
  end

  def create
    @event = Event.new(event_params)
    @event.host = current_user # Assuming your event model has a 'host' association to the user

    if @event.valid?
      @event.save
      redirect_to @event
    else
      @games = Game.all.order(:title)  # or some other necessary collection
      render :new
    end
  end

  def edit
  end

  def update
    if @event.update(event_params)
      redirect_to @event, notice: "Event was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event.destroy

    respond_to do |format|
      format.html { redirect_back fallback_location: my_events_path, notice: "Event was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :description, :date_time, :location, :capacity, :game_id)
  end
end
