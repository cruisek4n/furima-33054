class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
   # @items = Item.includes(:user).order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :information, :category_id, :image,
                                 :item_condition_id, :delivery_charge_pay_method_id, :prefecture_id,
                                 :scheduled_delivery_id, :price).merge(user_id: current_user.id)
  end
end
