class HomesController < ApplicationController

  def top
    @items = Item.order('id DESC').limit(4)
    # ASCだと古い順でDESCで新着順です。

  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :price)
  end



  def image_params
    params.require(:image).permit(:name, :introduction, :price)
  end

end
