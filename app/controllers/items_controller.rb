class ItemsController < ApplicationController

before_action :authenticate_user!, except:[:index,:show]
before_action :item_user_id, only:[:edit,:update,:show]

def index
  @items = Item.all.order("created_at DESC")
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

def show
end

def edit
  if current_user.id != @item.user_id
    redirect_to root_path
  end
end

def update
  if current_user.id != @item.user_id
    redirect_to root_path
  end

  if @item.update(item_params)
    redirect_to item_path(@item)
  else
    render :edit
  end
end

def destroy
  item =Item.find(params[:id])
  if item.destroy
    redirect_to root_path
  end

end

private
  def item_params
    params.require(:item).permit(:name, :text, :category_id, :condition_id, :postage_id, :area_id, :day_id, :price, :image).merge(user_id: current_user.id)
  end

  def item_user_id
    @item = Item.find(params[:id])
  end
end
