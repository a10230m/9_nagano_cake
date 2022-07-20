class Public::CartItemsController < ApplicationController


  def index
    @cart_items = current_cart_items.includes([:item])
    # @total = @cart_items.inject(0) { |sum, item| sum + item.sum_of_price }
  end
 # アイテムの追加
  def add
    @cart_item ||= current_cart_items.build(product_id: params[:item_id])
    @cart_item.quantity += params[:quantity].to_i
    if  @cart_item.save
      flash[:notice] = '商品が追加されました。'
      redirect_to public_cart_items_path
    else
      flash[:alert] = '商品の追加に失敗しました。'
      redirect_to public_item_path(params[:item_id])
    end
  end

# アイテムの更新
  def update
    if @cart_item.update(quantity: params[:quantity].to_i)
      flash[:notice] = 'カート内のギフトが更新されました'
    else
      flash[:alert] = 'カート内のギフトの更新に失敗しました'
    end
    redirect_to public_cart_items_path
  end

  # アイテムの削除
  def destroy
    if @cart_item.destroy
      flash[:notice] = 'カート内のギフトが削除されました'
    else
      flash[:alert] = '削除に失敗しました'
    end
    redirect_to public_cart_items_path
  end


  private

  def setup_cart_item!
    @cart_item = current_cart_items.find_by(item_id: params[:item_id])
  end



end
