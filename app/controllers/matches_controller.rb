class MatchesController < ApplicationController
  before_action :require_login
  before_action :set_match, only: [:show, :edit, :update]
  helper_method :round_options

  def new
    @match = Match.new
  end

  def create
    @match = Match.create(match_params)
    redirect_to match_path(@match)
  end

  def show
  end

  private

  def match_params
    params.require(:match).permit(:date, :time, :round, :score, :won, :tournament_id)
  end

  def set_match
    @match = Match.find(params[:id])
  end 
end
