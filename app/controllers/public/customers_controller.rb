class Public::CustomersController < ApplicationController





  def show
    # @customer = Customer.find(params[:id])
    @customer = current_customer
    
  end



  private

  def customer_params
    params.require(:customer).permit(:email, :password, :last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :is_active)

  end


end
