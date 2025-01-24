class Item < ApplicationRecord
  belongs_to :user
  #has_one :order
  has_one_attached :image

  validates :name,  presence: true
  validates :description,  presence: true
  validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 300,  less_than_or_equal_to: 9_999_999}
  validates :image, presence: true
  
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_fee
  belongs_to :prefecture
  belongs_to :shipping_day
  
  validates :category_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :condition_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :shipping_fee_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :prefecture_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :shipping_day_id, numericality: { other_than: 1 , message: "can't be blank"}
end
