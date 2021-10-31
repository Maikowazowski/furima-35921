class ItemTag

  include ActiveModel::Model
  attr_accessor :image, :title, :description, :category_id, :condition_id, :shipping_fee_id, :shipping_from_id, :scheduled_delivery_id, :price, :user_id, :item_id, :name

  with_options presence: true do
    validates :image
    validates :title
    validates :description
    validates :name
    with_options numericality: { other_than: 1, message: "can't be blank" } do
      validates :category_id
      validates :condition_id
      validates :shipping_fee_id
      validates :shipping_from_id
      validates :scheduled_delivery_id
    end
    validates :price, numericality: { only_integer: true, message: 'is invalid. Input half-width characters' },
                      numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, message: 'is out of setting range' }
  end

  def save
    item = Item.create(image: image, title: title, description: description, category_id: category_id, condition_id: condition_id, shipping_fee_id: shipping_fee_id, shipping_from_id: shipping_from_id, scheduled_delivery_id: scheduled_delivery_id, price: price, user_id: user_id)
    tag_list = name.split(',')
    tag_list.each do |tag_name|
      tag = Tag.where(name: tag_name).first_or_initialize
      tag.save
      ItemTagRelation.create(item_id: item.id, tag_id: tag.id)
    end  
  end

  def update
   @item = Item.find(item_id)
   item = @item.update(image: image, title: title, description: description, category_id: category_id, condition_id: condition_id, shipping_fee_id: shipping_fee_id, shipping_from_id: shipping_from_id, scheduled_delivery_id: scheduled_delivery_id, price: price, user_id: user_id)
    tag_list = name.split(',')
    tag_list.each do |tag_name|
      tag = Tag.where(name: tag_name).first_or_initialize
      tag.save
      unless ItemTagRelation.where(item_id: item_id, tag_id: tag.id).exists?
        ItemTagRelation.create(item_id: item_id, tag_id: tag.id)
      end
    end
  end
end