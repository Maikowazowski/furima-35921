class Item < ApplicationRecord
  belongs_ to :user
  
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_fee
  belongs_to :shipping_from
  belongs_to :scheduled_delivery

  with_options presence: true do
    validates :title 
    validates :description
    validates :category_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :condition_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :shipping_fee_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :shipping_from_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :scheduled_delivery_id, numericality: { other_than: 1, message: "can't be blank" }
  end

  validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, message: 'is out of setting range'}, format: { with: /\A[0-9]+\z/, message: 'is invalid. Input half-width characters' }

end
