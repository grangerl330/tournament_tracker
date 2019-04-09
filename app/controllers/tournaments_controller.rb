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
    update_user_points
    
    redirect_to tournament_path(@tournament)
  end

  def index
    if params[:user_id]
      @tournaments = User.find(params[:user_id]).tournaments
    end
  end

  def show
  end

  def edit
  end

  def update
    @tournament.update(tournament_params)
    redirect_to tournament_path(@tournament)
  end

  def destroy
    remove_points_from_user
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

  def draw_size_options
    [256, 128, 64, 32, 16, 8, 4, 2]
  end

  def add_points_to_user
    current_user.points += @tournament.points
    current_user.save
  end

  def remove_points_from_user
    current_user.points -= @tournament.points
    current_user.save
  end

  def update_user_points
    if @tournament.points_gained?
      add_points_to_user
    end
  end
end
