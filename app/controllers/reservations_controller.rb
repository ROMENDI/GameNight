class ReservationsController < ApplicationController
  before_action :set_reservation, only: [:show, :edit, :update, :destroy]

  def new
    @event = Event.find(params[:event_id])
    @reservation = Reservation.new
  end

  def create
    @reservation = Reservation.new(reservation_params)
    @reservation.sender = current_user # Assuming you have user authentication

    if @event.host_id == current_user.id
      redirect_to @event, alert: "You cannot make a reservation for your own event."
      return
    end

    if @reservation.save
      redirect_to @reservation.event, notice: "Reservation was successfully created."
    else
      @event = @reservation.event
      flash.now[:alert] = @reservation.errors.full_messages.to_sentence
      render "events/show"
    end
  end

  def edit; end

  def update
    if @reservation.update(reservation_params)
      redirect_to @reservation.event, notice: "Reservation was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @event = @reservation.event
    @reservation.destroy
    redirect_to @event, notice: "Reservation was successfully cancelled."
  end

  private

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  def reservation_params
    params.require(:reservation).permit(:event_id, :status)
  end
end
