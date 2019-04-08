class MatchesController < ApplicationController
  before_action :require_login
  before_action :set_tournament, only: [:show, :edit, :update]
  helper_method :round_options

  def new
    @match = Match.new
  end

  def create
    @match = Match.new(match_params)
  end

  private

  def match_params
    params.require(:match).permit(:round, :score)
  end
end
