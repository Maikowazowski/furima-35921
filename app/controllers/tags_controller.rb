class TagsController < ApplicationController
  def show
    @tag = Tag.find(params[:id])
    @items = @tag.items.order("created_at DESC")
  end
end
