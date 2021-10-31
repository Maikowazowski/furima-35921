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

end
