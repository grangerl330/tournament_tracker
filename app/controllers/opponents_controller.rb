class OpponentsController < ApplicationController
  before_action :require_login
  before_action :set_opponent

  def show
  end

  def edit
  end

  def update
    @opponent.update(opponent_params)
    redirect_to opponent_path(@opponent)
  end

  private

  def opponent_params
    params.require(:opponent).permit(:first_name, :last_name, :age, :handedness, :match_id)
  end

  def set_opponent
    @opponent = Opponent.find(params[:id])
  end

end
