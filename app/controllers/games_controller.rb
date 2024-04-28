class GamesController < ApplicationController
  def index
    @games = Game.order(:title)
    #Filter by game name
    if params[:search].present?
      @games = Game.where('title LIKE ?', "%#{params[:search]}%")
    else
      @games = Game.order(:title)
    end
  end

  def show
    @game = Game.find(params[:id])
    @events = @game.events
  end
  
end
