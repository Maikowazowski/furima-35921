class ItemsController < ApplicationController
  before_action :move_to_index, except: [:index]

  def index
  end
  
  def new
  end

  def create
  end

  private

  def move_to_index
   unless user_signed_in?
   redirect_to action: :index
   end
  end

  def item_params
    params.require(:item).permit(:image, :title, :description, :category_id, :condition_id, :shipping_fee_id, :shipping_from_id, :scheduled_delivery_id, :price).merge(user_id: current_user.id)
  end
  
end
