class OrderShippingAddress
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id, :city, :address_line, :building_name, :phone_number
  
  # バリデーション
  with_options presence: true do
  validates :user_id
  validates :item_id
  validates :postal_code, format: { with:/\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)" }
  validates :prefecture_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :city
  validates :address_line
  validates :phone_number, format: { with: /\A[0-9]{10,11}\z/  }
  end
  
  def save
  order = Order.create(user_id: user_id, item_id: item_id)
  ShippingAddress.create(
  order_id: order.id,
  postal_code: postal_code,
  prefecture_id: prefecture_id,
  city: city,
  address_line: address_line,
  building_name: building_name,
  phone_number: phone_number
  )
  end
end