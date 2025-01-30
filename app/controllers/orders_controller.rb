class OrdersController < ApplicationController
  before_action :set_item
  before_action :authenticate_user!
  
def index
  @order_shipping_address = OrderShippingAddress.new
end
  
def create
  @order_shipping_address = OrderShippingAddress.new(order_shipping_address_params)
  if @order_shipping_address.valid?
    @order_shipping_address.save
    redirect_to root_path
  else
    render :index, status: :unprocessable_entity
  end
end
  
private
  def order_shipping_address_params
    params.require(:order_shipping_address).permit(:postal_code, :prefecture_id, :city, :address_line, :building_name, :phone_number).merge(user_id: current_user.id, item_id: @item.id)
  end
  
  def set_item
    @item = Item.find(params[:item_id])
  end
end