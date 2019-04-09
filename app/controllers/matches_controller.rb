class MatchesController < ApplicationController
  before_action :require_login
  before_action :set_match, only: [:show, :edit, :update, :destroy]
  helper_method :round_options

  def new
    @match = Match.new
    @match.build_opponent
    @tournament = Tournament.find_by_id(params[:tournament_id])
  end

  def create
    @match = Match.create(match_params)
    add_to_user_record
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
    redirect_to match_path(@match)
  end

  def destroy
    tournament = @match.tournament
    remove_from_user_record
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

  def add_win_to_user
    current_user.match_wins += 1
    current_user.save
  end

  def add_loss_to_user
    current_user.match_losses += 1
    current_user.save
  end

  def remove_win_from_user
    current_user.match_wins -= 1
    current_user.save
  end

  def remove_loss_from_user
    current_user.match_losses -= 1
    current_user.save
  end

  def add_to_user_record
    if @match.won
      add_win_to_user
    else
      add_loss_to_user
    end
  end

  def remove_from_user_record
    if @match.won
      remove_win_from_user
    else
      remove_loss_from_user
    end
  end
end
