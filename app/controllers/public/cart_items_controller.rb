class Public::CartItemsController < ApplicationController


  def index
    @cart_items = current_customer.cart_items

    end
  end



  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    # 追加した商品がカート内に存在するかの判別
    # 存在した場合
    if current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id]).present?
      cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
      # カート内の個数をフォームから送られた個数分追加する
      cart_item.amount += params[:cart_item][:amount].to_i
      cart_item.save

      redirect_to public_cart_items_path
    # 存在しなかった場合
    else
      @cart_item.save
      redirect_to public_cart_items_path
    end
  end



  def update
    @cart_item=CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to  public_cart_items_path(cart_item.id)
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to public_cart_items_path
  end

  def all_destroy
    @cart_items = current_customer.cart_items
    @cart_items.destroy_all
    redirect_to public_cart_items_path
  end


  private

  def cart_item_params
    params.require(:cart_item).permit(:customer_id, :item_id, :amount)
  end

# end