class Public::CartItemsController < ApplicationController

  # def new
  #   @cart_item = Cart_item.new
  # end

  def create
    # @cart_itemを定義（find_byでどの情報のアイテムを持ってくるのかパラメータを参考に記述）
    @cart_item = CartItem.find_by(item_id: params[:cart_item][:item_id], customer_id: current_customer.id)
    #初めて対象商品をカートに追加する場合
      if @cart_item.blank?
        @cart_item = CartItem.new(cart_items_params)
      end
    #すでに追加する商品がカートにある場合
    @cart_item.amount += params[:cart_item][:amount].to_i
    @cart_item.customer_id = current_customer.id
    @cart_item.save
    redirect_to cart_items_path
  end



  def index
    @cart_items = current_customer.cart_items
    @total = 0
      # @total = @cart_items.inject(0) { |sum, item| sum + item.sum_of_price }
  end

  private

    def cart_item_params
      params.require(:cart_item).permit(:item_id, :amount)
    end

end
