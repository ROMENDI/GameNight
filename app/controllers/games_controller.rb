class GamesController < ApplicationController
  def index
    if params[:search].present?
      @games = Game.search_by_title(params[:search]).order(:title)
    else
      @games = Game.order(:title)
    end
    
  end

  def show
    @game = Game.find(params[:id])
    @events = @game.events
  end
  
end
