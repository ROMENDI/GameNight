class ReservationsController < ApplicationController
  def create
    @reservation = Reservation.new(reservation_params)
    @reservation.sender = current_user

    if @reservation.save
      redirect_to event_path(@reservation.event), notice: "Reservation successfully created."
    else
      render "events/show", status: :unprocessable_entity
    end
  end

  def update
    @reservation = current_user.reservations.find(params[:id])

    if @reservation.update(reservation_params)
      redirect_to event_path(@reservation.event), notice: "Reservation successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @reservation = current_user.reservations.find(params[:id])
    event = @reservation.event
    @reservation.destroy
    redirect_to event_path(event), notice: 'Reservation successfully canceled.'
  end

end
