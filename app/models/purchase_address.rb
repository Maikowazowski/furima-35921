class PurchaseAddress
  include ActiveModel::Model
  attr_accessor :token, :item_id, :user_id, :postal_code, :prefecture, :city, :house_number, :building_name, :phone_number

  with_options presence: true do
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Enter it as follows (e.g. 123-4567)"}
    validates :prefecture, numericality: {other_than: 1, message: "can't be blank"}
    validates :city
    validates :house_number
    validates :phone_number, length: {in: 10..11, message: "is too short"}, numericality: {only_integer: true, message: "is invalid. Input only number"}
    validates :token
    validates :user_id
    validates :item_id
  end

  def save
    purchase = Purchase.create(item_id: item_id, user_id: user_id)
    Address.create(token: token, postal_code: postal_code, prefecture: prefecture, city: city, house_number: house_number, building_name: building_name, phone_number: phone_number, purchase_id: purchase.id)
  end
end