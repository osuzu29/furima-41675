class ItemsController < ApplicationController
  before_action :authenticate_user! ,only: [:new ,:create ,:edit ,:destroy]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :move_to_index, only: [:edit, :update]
  def index
    @items = Item.order("created_at DESC")
  end

  def new
    @item = Item.new
  end
    
  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

    
  private

  def move_to_index
    unless current_user == @item.user
      redirect_to root_path
    end
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:image,:name, :description, :category_id,:condition_id,:shipping_fee_id,:prefecture_id,:shipping_day_id,:price).merge(user_id: current_user.id)
  end

end
