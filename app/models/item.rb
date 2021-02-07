class Item < ApplicationRecord
  with_options presence: true do
    validates :name
    validates :information
    validates :price,
              numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, message: 'Out of setting range' }
    validates :image
  end
  validates :price, numericality: { with: /\A[0-9]+\z/, message: 'Half-width number' }

  with_options numericality: { other_than: 1, message: 'Select' } do
    validates :category_id
    validates :item_condition_id
    validates :delivery_charge_pay_method_id
    validates :prefecture_id
    validates :scheduled_delivery_id
  end

  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :item_condition
  belongs_to :delivery_charge_pay_method
  belongs_to :prefecture
  belongs_to :scheduled_delivery
end
