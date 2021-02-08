class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :item_params 

  def index
     @item_address = ItemAddress.new
      if current_user.id == @item.user.id || @item.order_ids.present? 

        redirect_to root_path
      end
      
  end

  def create
    @item_address = ItemAddress.new(order_params)
    if @item_address.valid? 
      pay_item
      @item_address.save
      return redirect_to "/items/#{params[:item_id]}"
    else
      render :index
    end
  end
    
    private

    def pay_item
      Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      Payjp::Charge.create(
        amount: @item.price,
        card:order_params[:token],
        currency: 'jpy'
      )
    end

    def order_params
      params.require(:item_address).permit(:postal_code,:area_id,:cities,:house_number,:building_name,:tel).merge(user_id: current_user.id, item_id: params[:item_id],token: params[:token] )
    end

    def item_params
      @item = Item.find(params[:item_id])
    end
 
  end
  