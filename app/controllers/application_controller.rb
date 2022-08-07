class ApplicationController < ActionController::Base


  before_action :authenticate_customer!, except: [:top, :about, :index]
  before_action :configure_sign_up_params, if: :devise_controller?


  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :is_active])
  end




  def after_sign_in_path_for(resource)
    case resource
    when Admin
      admin_items_path
    when Customer
      customers_mypage_path
    end
  end

  # def after_sign_up_path_for(resource)
    # case resource
    # when Admin
      # admin_path
    # when Customer
      # public_end_users_show_path
    # end
  # end

  # def after_sign_out_path_for(resource)
    # if resource == :admin
      # new_admin_session_path
    # else
    # root_path
    # end
  # end

  # protect_from_forgery with: :exception

  helper_method :current_cart_items

  # def current_cart_items
  #   current_customer
  #     # ユーザーとカートの紐付け
  #     current_cart_items = current_customer || current_customer.create_cart_items!

  # end


end


