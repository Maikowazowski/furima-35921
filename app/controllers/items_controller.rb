class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :move_to_index, only: [:edit, :destroy]

  def index
    @items = Item.all.order("created_at DESC")
  end

  def new
    @item = ItemTag.new
  end

  def create
    @item = ItemTag.new(item_params)
    if @item.valid?
      @item.save
      redirect_to root_path 
    else
      render :new
    end
  end

  def search
    return nil if params[:keyword] == ""
    tag = Tag.where(['name LIKE ?', "%#{params[:keyword]}%"] )
    render json:{ keyword: tag }
  end

  def show
  end

  def edit
    @tags = @item.tags.pluck(:name).join(',')
    @item_tags = ItemTag.new(image: @image, title: @item.title, description: @item.description, category_id: @item.category_id, condition_id: @item.condition_id,shipping_fee_id: @item.shipping_fee_id,
                             shipping_from_id: @item.shipping_fee_id, scheduled_delivery_id: @item.scheduled_delivery_id, price: @item.price, name: @tags)
  end

  def update
    @item_tags = ItemTag.new(update_params)
    if @item_tags.valid? 
      @item_tags.update
      redirect_to item_path
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  private

  def item_params
    params.require(:item_tag).permit(:image, :title, :description, :category_id, :condition_id, :shipping_fee_id,
                                 :shipping_from_id, :scheduled_delivery_id, :price, :name).merge(user_id: current_user.id)
  end

  def update_params
    params.require(:item_tag).permit(:image, :title, :description, :category_id, :condition_id, :shipping_fee_id,
                                 :shipping_from_id, :scheduled_delivery_id, :price, :name).merge(user_id: current_user.id, item_id: @item.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def move_to_index
    unless user_signed_in? && current_user.id == @item.user.id
      redirect_to action: :index
    end
    if @item.purchase.present?
      redirect_to action: :index
    end
  end
end
