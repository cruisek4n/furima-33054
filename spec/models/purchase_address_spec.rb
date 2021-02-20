require 'rails_helper'

 RSpec.describe PurchaseAddress, type: :model do
   before do
     @purchase_address = FactoryBot.build(:purchase_address)
     @user = FactoryBot.create(:user)
     @item = FactoryBot.create(:item)
     @purchase_address.user_id = @user.id
     @purchase_address.item_id = @item.id
     sleep 0.1
   end

   describe '商品購入機能' do
    context '正常に購入が完了する場合' do
      it '全てのフォームが適切に入力されている場合' do
        expect(@purchase_address).to be_valid
      end
      it '住所が空欄でも登録ができる' do
        @purchase_address.building_name = ''
        expect(@purchase_address).to be_valid
      end
    end
    context '商品購入が正常にできない場合' do
      it 'tokenが空では購入できないこと' do
        @purchase_address.token =  ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Token can't be blank")
      end

      it '郵便番号が空欄の場合は購入できないこと' do
        @purchase_address.post_code = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Post code can't be blank")
      end

      it '郵便番号が半角のハイフンを含んだ正しい形式でないと購入できないこと' do
        @purchase_address.post_code = '1234567'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Post code is invalid. Include hyphen(-)')
      end
  
      it '郵便番号が半角の数字でない、かつハイフンがないと購入できないこと' do
        @purchase_address.post_code = '１２３−４５６７'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Post code is invalid. Include hyphen(-)')
      end
      
      it '郵便番号が半角数字の7桁でないと購入できないこと' do
        @purchase_address.post_code = '123-456'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Post code is invalid. Include hyphen(-)')
      end

      it '郵便番号がアルファベットの場合購入できないこと' do
        @purchase_address.post_code = 'asewqsd'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Post code is invalid. Include hyphen(-)')
      end
     
      it 'prefectureを選択していないと購入できないこと' do
        @purchase_address.prefecture_id = 1
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Prefecture Select')
      end
      
      it '市区町村が空では購入できないこと' do
        @purchase_address.city = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("City can't be blank")
      end

      it '番地が空だと購入できないこと' do
        @purchase_address.street_address = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Street address can't be blank")
      end
      
      it '電話番号が空だと購入できないこと' do
        @purchase_address.phone_number = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Phone number can't be blank")
      end

      it '電話番号は英数字混合では購入できないこと' do
        @purchase_address.phone_number = '080defgefe'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Phone number is invalid')
      end

       it '電話番号は10桁未満だと購入できないこと' do
        @purchase_address.phone_number = '08033'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Phone number is invalid")
      end

      it '電話番号は11桁を超えると購入できないこと' do
        @purchase_address.phone_number = '080333333333332'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Phone number is invalid")
      end

      it '電話番号は半角数字を入れないと購入できないこと' do
        @purchase_address.phone_number = '０８０９９９９９９９'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Phone number is invalid')
      end

      it '電話番号にハイフンが入ると購入できないこと' do
        @purchase_address.phone_number = '080-999-8888'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Phone number is invalid")
      end

      it 'user_idが空ではできないこと' do
        @purchase_address.user_id = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("User can't be blank")
      end

      it 'item_idが空では登録できないこと' do
        @purchase_address.item_id = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end