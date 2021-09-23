class Item < ApplicationRecord
  belongs_ to :user
  
  with_options presence: true do
    validates :title 
    validates :description
    validates :category_id
    validates :condition_id
    validates :shipping_fee_id
    validates :shipping_from_id
    validates :scheduled_delivery_id
  end

  validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, message: 'is out of setting range'}, format: { with: /\A[0-9]+\z/, message: 'is invalid. Input half-width characters' }

end
