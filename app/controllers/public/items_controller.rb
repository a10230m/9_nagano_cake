class Public::ItemsController < ApplicationController

  def index
    @items = Item.page(params[:page]).per(8)
    @item_count = Item.where(params[:item_id]).count
  end

  def show
    @item = Item.find(params[:id])
    @customer = current_customer
  end


  private

  def item_params
    params.require(:item).permit(:image, :name, :introduction, :price)
  end



  def image_params
    params.require(:image).permit(:name, :introduction, :price)
  end
end
