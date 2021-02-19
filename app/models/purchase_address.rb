class PurchaseAddress
  include ActiveModel::Model
  attr_accessor :post_code, :prefecture_id, :city, :street_address, :building_name, :phone_number, :user_id, :item_id, :token

  with_options presence: true do
    validates :post_code, format: { with: /\A\d{3}-\d{4}\z/, message: 'is invalid. Include hyphen(-)' }
    validates :city
    validates :street_address
    validates :phone_number, format: { with: /\A\d{11}\z/, message: 'is invalid' }
    validates :token
  end
  validates :prefecture_id, numericality: { other_than: 1, message: 'Select' }

  def save
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    Address.create(post_code: post_code, prefecture_id: prefecture_id, city: city, street_address: street_address,
                   building_name: building_name, phone_number: phone_number, purchase_id: purchase.id)
  end
end
