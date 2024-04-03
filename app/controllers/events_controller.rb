class EventsController < ApplicationController
  def index
    @events = Event.all
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
  end 

  def destroy
  end 
  
end
