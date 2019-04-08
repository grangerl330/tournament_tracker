class TournamentsController < ApplicationController

  def new
    @tournament = Tournament.new
  end

  def create
    @tournament = Tournament.new(tournament_params)
    @tournament.user_id = current_user.id
    @tournament.save
    redirect_to tournament_path(@tournament)
  end

  private

  def tournament_params
    params.require(:tournament).permit(:title, :date, :location, :draw_size, :points)
  end

end
