class OrdersController < ApplicationController

  def index
     @item = Item.find(params[:item_id])
     @order = Order.new
  end

  def create
    @item = Item.find(params[:item_id])
    @order= Order.new(order_params)
      if @order.valid?
        pay_item
        @order.save
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
      params.require(:order).permit().merge(user_id: current_user.id, item_id: params[:item_id],token: params[:token])
    end
    
  end
  # .permit(:postal_code,:area,:cities,:house_number,:building_name,:tel)
  