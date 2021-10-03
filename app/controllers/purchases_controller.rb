class PurchasesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :create]
  before_action :move_to_index, only: [:index, :create]

  def index
    @purchase_address = PurchaseAddress.new
  end

  def create
    @purchase_address = PurchaseAddress.new(address_params)
    if @purchase_address.valid?
      pay_item
      @purchase_address.save
      return redirect_to root_path
    else
      render 'index'
    end

  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def address_params
    params.require(:purchase_address).permit(:postal_code, :prefecture, :city, :house_number, :building_name, :phone_number).merge(token: params[:token], item_id: @item.id,user_id: current_user.id)
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      Payjp::Charge.create(
        amount: @item.price,
        card: address_params[:token],
        currency: 'jpy'
      )
  end

  def move_to_index
    if (user_signed_in? && current_user.id == @item.user.id) || (@item.purchase.present?)
      redirect_to root_path
    end
  end

end
