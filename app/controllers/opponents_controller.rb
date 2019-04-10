class OpponentsController < ApplicationController
  before_action :require_login
  before_action :set_opponent, only: [:show, :edit, :update, :destroy]

  def index
    @style_tags = StyleTag.all

    if params[:style_tag_ids]
      search
    else
      @opponents = current_user.opponents
    end
  end

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
    params.require(:opponent).permit(:search, :first_name, :last_name, :age, :handedness, :match_id, style_tag_ids: [], style_tags_attributes: [:name])
  end

  def set_opponent
    @opponent = Opponent.find(params[:id])
  end

  def search
    @opponents = Opponent.joins(:opponent_style_tags).where(
      opponent_style_tags: { style_tag_id: params[:style_tag_ids] }
    ).uniq
  end

end
