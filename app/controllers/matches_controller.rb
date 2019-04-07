class MatchesController < ApplicationController
  before_action :require_login
  before_action :set_match, only: [:show, :edit, :update, :destroy]
  before_action :convert_params_round_to_number, only: [:create, :update]

  def new
    @match = Match.new
    @match.build_opponent
    @tournament = Tournament.find_by_id(params[:tournament_id])
  end

  def create
    @match = Match.create(match_params)
    @match.add_to_user_record
    redirect_to match_path(@match)
  end

  def show
  end

  def edit
    @tournament = @match.tournament
    @opponent = @match.opponent
  end

  def update
    @match.update(match_params)
    @match.update_user_record
    redirect_to match_path(@match)
  end

  def destroy
    tournament = @match.tournament
    @match.remove_from_user_record
    @match.destroy
    redirect_to tournament_path(tournament)
  end

  private

  def match_params
    params.require(:match).permit(:date, :time, :round, :score, :won, :tournament_id, opponent_id:[], opponent_attributes: [:first_name, :last_name, :age, :handedness])
  end

  def set_match
    @match = Match.find(params[:id])
  end

  def convert_params_round_to_number
    case params[:match][:round]
    when "Quarter-Final"
      params[:match][:round] = 8
    when "Semi-Final"
      params[:match][:round] = 4
    when "Final"
      params[:match][:round] = 2
    end
  end
end
