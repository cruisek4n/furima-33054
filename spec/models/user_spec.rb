require 'rails_helper'

RSpec.describe User, type: :model do
  
    before do
      @user = FactoryBot.build(:user)
    end
    describe 'ユーザー新規登録' do
      context '新規登録できる時' do
        it "nicknameとemail、password、password_confirmation、last_name、first_name、
            last_name_kana、first_name_kana、birth_dateが存在すれば登録できること" do
        expect(@user).to be_valid
        end
      end

      context '新規登録できない時' do
       it "nicknameが空では登録できないこと" do
       @user.nickname = ""
       @user.valid?
       expect(@user.errors.full_messages).to include("Nickname can't be blank")
       end

       it "重複したnicknameが存在する場合登録できないこと" do
       @user.save
       another_user = FactoryBot.build(:user, nickname: @user.nickname)
       another_user.valid?
       expect(another_user.errors.full_messages).to include("Nickname has already been taken")
       end

       it "emailが空では登録できないこと" do
       @user.email = ""
       @user.valid?
       expect(@user.errors.full_messages).to include("Email can't be blank")
       end

       it "emailに@がないと登録できない" do
       @user.email = "cruisek4n.co.kr"
       @user.valid?
       expect(@user.errors.full_messages).to include("Email is invalid")
       end

       it "重複したemailが存在する場合登録できないこと" do
       @user.save
       another_user = FactoryBot.build(:user, email: @user.email)
       another_user.valid?
       expect(another_user.errors.full_messages).to include("Email has already been taken")
       end

       it "passwordが空では登録できないこと" do
       @user.password = ""
       @user.valid?
       expect(@user.errors.full_messages).to include("Password can't be blank")
       end

       it "passwordが半角英数字混合でなければ登録できない" do
       @user.password = "68686868668"
       @user.valid?
       expect(@user.errors.full_messages).to include("Password Include both letters and numbers")
       end

       it "passwordが5文字以下であれば登録できないこと" do
       @user.password = "12345"
       @user.password_confirmation = "12345"
       @user.valid?
       expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
       end

       it "passwordとpassword_confirmationが不一致では登録できないこと" do
       @user.password = "123456"
       @user.password_confirmation = "1234567"
       @user.valid?
       expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
       end

       it "last_nameが空では登録できないこと" do
       @user.last_name = ""
       @user.valid?
       expect(@user.errors.full_messages).to include("Last name can't be blank")
       end

       it "last_nameが全角入力でなければ登録できないこと" do
       @user.last_name = "ｱｲｳｴｵ"
       @user.valid?
       expect(@user.errors.full_messages).to include("Last name Full-width characters")
       end
      
       it "first_nameが空では登録できないこと" do
       @user.first_name = ""
       @user.valid?
       expect(@user.errors.full_messages).to include("First name can't be blank")
       end

       it "first_nameが全角入力でなければ登録できないこと" do
       @user.first_name = "ｱｲｳｴｵ"
       @user.valid?
       expect(@user.errors.full_messages).to include("First name Full-width characters")
       end
    
       it "last_name_kanaが空では登録できないこと" do
       @user.last_name_kana = ""
       @user.valid?
       expect(@user.errors.full_messages).to include("Last name kana can't be blank")
       end
       it "last_name_kanaが全角カタカナでなければ登録できないこと" do
       @user.last_name_kana = "あいうえお"
       @user.valid?
       expect(@user.errors.full_messages).to include("Last name kana Full-width katakana characters")
       end
       
       it "first_name_kanaが空では登録できないこと" do
       @user.first_name_kana = ""
       @user.valid?
       expect(@user.errors.full_messages).to include("First name kana can't be blank")
       end

       it "first_name_kanaが全角カタカナでなければ登録できないこと" do
       @user.first_name_kana = "あいうえお"
       @user.valid?
       expect(@user.errors.full_messages).to include("First name kana Full-width katakana characters")
       end

       it "birth_dateが空では登録できないこと" do
       @user.birth_date = ""
       @user.valid?
       expect(@user.errors.full_messages).to include("Birth date can't be blank")
       end
      end
    end
end

