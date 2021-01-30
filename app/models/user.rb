class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :password, format: { with: /(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]{7,}/,
                                 message: 'Include both letters and numbers' }

  with_options presence: true do
    validates :nickname, uniqueness: true, length: { maximum: 40 }
    validates :last_name, format: { with: /\A[ぁ-んァ-ン一-龥]+\z/,
                                    message: 'Full-width characters' }
    validates :first_name, format: { with: /\A[ぁ-んァ-ン一-龥]+\z/,
                                     message: 'Full-width characters' }
    validates :last_name_kana, format: { with: /\A[ァ-ヶー－]+\z/,
                                         message: 'Full-width katakana characters' }
    validates :first_name_kana, format: { with: /\A[ァ-ヶー－]+\z/,
                                          message: 'Full-width katakana characters' }
    validates :birth_date
  end
end
