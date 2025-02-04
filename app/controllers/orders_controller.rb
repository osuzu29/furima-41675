class OrdersController < ApplicationController
  before_action :set_item
  before_action :authenticate_user!
  before_action :set_gon, only: [:index]
  before_action :authenticate_user!  
  before_action :move_to_index, only: [:index]
  before_action :soldout_to_index, only: [:index]
  
def index
  @order_shipping_address = OrderShippingAddress.new
end
  
def create
  @order_shipping_address = OrderShippingAddress.new(order_shipping_address_params)
  if @order_shipping_address.valid?
    pay_item
    @order_shipping_address.save
    redirect_to root_path
  else
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    render :index, status: :unprocessable_entity
  end
end
  
private
  def order_shipping_address_params
    params.require(:order_shipping_address).permit(:postal_code, :prefecture_id, :city, :address_line, :building_name, :phone_number).merge(user_id: current_user.id, item_id: @item.id,token: params[:token])
  end
  
  def set_item
    @item = Item.find(params[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
    amount: Item.find(params[:item_id]).price,
    card: order_shipping_address_params[:token],  
    currency: 'jpy'
    )
  end

  def set_gon
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
  end

  def move_to_index
    if current_user == @item.user
    redirect_to root_path
    end
  end
    
  def soldout_to_index
    if @item.order.present?
    redirect_to root_path
    end
  end
end