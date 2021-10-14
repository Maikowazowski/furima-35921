class Item < ApplicationRecord
  belongs_to :user
  has_one :purchase
  has_one_attached :image
  has_many :item_tag_relations
  has_many :tags, through: :item_tag_relations

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_fee
  belongs_to :shipping_from
  belongs_to :scheduled_delivery

  with_options presence: true do
    validates :image
    validates :title
    validates :description
    with_options numericality: { other_than: 1, message: "can't be blank" } do
      validates :category_id
      validates :condition_id
      validates :shipping_fee_id
      validates :shipping_from_id
      validates :scheduled_delivery_id
    end
    validates :price, numericality: { only_integer: true, message: 'is invalid. Input half-width characters' },
                      inclusion: { in: 300..9_999_999, message: 'is out of setting range' }
  end
end
