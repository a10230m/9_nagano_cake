class Admin::ItemsController < ApplicationController

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to admin_item_path(item.id)
    else
      render :new
    end
  end

  def index
    @items = Item.all

    # @item = Item.new
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