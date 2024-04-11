class EventsController < ApplicationController
  before_action :set_event, only: [:edit, :update, :delete]
  
  def check_geocode_error
    puts errors.full_messages.to_sentence
  end

  def index
    @events = Event.where.not(host_id: current_user.id)
  end

  def show
    @event = Event.find(params[:id])
  end

  def my_events
    @hosted_events = current_user.hosted_events
    @reserved_events = current_user.reserved_events 
  end


  def new
    @event = Event.new
    @games = Game.all.order(:title)
  end
  
  def create
    @event = Event.new(event_params)
    @event.host = current_user # Assuming your event model has a 'host' association to the user
  
    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: "Event was successfully created." }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    if @event.update(event_params)
      redirect_to @event, notice: 'Event was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end 

  def destroy
    if @event
      @event.destroy
      redirect_to events_url, notice: 'Event was successfully deleted.', status: :see_other
    else
      redirect_to events_url, alert: 'Event not found.', status: :not_found
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
