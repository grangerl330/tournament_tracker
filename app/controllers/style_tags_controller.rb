class StyleTagsController < ApplicationController

  def index
    @style_tags = StyleTag.all
  end

  def new
  end

  def create
  end
end
