class Public::ItemsController < ApplicationController

  def index
    @items = Item.page(params[:page])
  end

  def show
    @item = Item.find(params[:id])
  end


  private

  def item_params
    params.require(:item).permit(:image, :name, :introduction, :price)
  end



  def image_params
    params.require(:image).permit(:name, :introduction, :price)
  end
end
