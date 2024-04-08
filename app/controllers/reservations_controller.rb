class ReservationsController < ApplicationController
  before_action :set_reservation, only: [:edit, :update]

  def new
    @event = Event.find(params[:event_id])
    @reservation = Reservation.new
  end

  def create
    @reservation = Reservation.new(reservation_params)
    @reservation.sender = current_user # Assuming you have user authentication

    if @reservation.save
      redirect_to @reservation.event, notice: 'Reservation was successfully created.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @reservation.update(reservation_params)
      redirect_to @reservation.event, notice: 'Reservation was successfully updated.'
    else
      render :edit
    end
  end

  private

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  def reservation_params
    params.require(:reservation).permit(:event_id, :status)
  end
end
