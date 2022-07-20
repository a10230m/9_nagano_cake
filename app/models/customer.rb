class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :cart_items, dependent: :destroy
  has_one :orders, dependent: :destroy
  has_one :addresses, dependent: :destroy


  def active_for_authentication?
    super && (is_deleted == false)
  end
end
