class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :password, format: { with: /(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]{7,}/,
                                 message: 'Include both letters and numbers' }

  with_options presence: true do
   validates :nickname, uniqueness: true, length: { maximum: 40 }
   validates :birth_date
    with_options format: { with: /\A[ぁ-んァ-ン一-龥]+\z/,
      message: 'Full-width characters' } do
    validates :last_name
    validates :first_name 
    end
    with_options format: { with: /\A[ァ-ヶー－]+\z/,
      message: 'Full-width katakana characters' } do
    validates :last_name_kana 
    validates :first_name_kana
    end
  end
end
