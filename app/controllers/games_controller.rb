class GamesController < ApplicationController
  def index
    @games = Game.all
  end

  def show
    @game = Game.find(params[:id])
    @events = @game.events
  end

  def new
  end

  def edit
  end

  def create
  end

  def update
  end

  def destroy
  end
end
