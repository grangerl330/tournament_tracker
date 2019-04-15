class TournamentsController < ApplicationController
  before_action :require_login
  before_action :set_tournament, only: [:show, :edit, :update, :destroy]
  helper_method :draw_size_options

  def new
    @tournament = Tournament.new
  end

  def create
    @tournament = Tournament.new(tournament_params)
    @tournament.user_id = current_user.id
    @tournament.save
    if @tournament.points
      @tournament.update_user_points
    end

    redirect_to tournament_path(@tournament)
  end

  def index
    if params[:user_id]
      @tournaments = tournaments_sorted_by_date
    end
  end

  def show
  end

  def edit
  end

  def update
    @tournament.update(tournament_params)
    if @tournament.points
      @tournament.update_user_points
    end
    redirect_to tournament_path(@tournament)
  end

  def destroy
    @tournament.remove_points_from_user
    @tournament.destroy_all_matches
    @tournament.destroy
    redirect_to user_path(current_user)
  end

  private

  def tournament_params
    params.require(:tournament).permit(:title, :start_date, :end_date, :location, :draw_size, :points)
  end

  def set_tournament
    @tournament = Tournament.find_by_id(params[:id])
  end

  def tournaments_sorted_by_date
    tournament_array = User.find(params[:user_id]).tournaments
    tournament_array.sort_by {|tournament| tournament.start_date}
  end
end
