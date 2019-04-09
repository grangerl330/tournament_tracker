class StyleTagsController < ApplicationController
  before_action :set_style_tag, only:[:edit, :update, :destroy]

  def index
    @style_tags = StyleTag.all
  end

  def new
    @style_tag = StyleTag.new
  end

  def create
    StyleTag.create(style_tag_params)
    redirect_to style_tags_path
  end

  def edit
  end

  def update
    @style_tag.update(style_tag_params)
    redirect_to style_tags_path
  end

  def destroy
    @style_tag.destroy
    redirect_to style_tags_path
  end

  private

  def set_style_tag
    @style_tag = StyleTag.find(params[:id])
  end

  def style_tag_params
    params.require(:style_tag).permit(:name)
  end
end
