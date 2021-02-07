require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end
  describe '商品出品機能' do
    context '商品出品が保存できる場合' do
      it '出品画像、商品名、商品の説明、カテゴリー、商品の状態、配送料の負担、配送元の地域、配送までの日数、価格があれば、商品出品は保存される ' do
        expect(@item).to be_valid
      end
    end

    context '商品出品が保存できない場合' do
      it '画像が空では保存できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end

      it '商品名が空では保存できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end

      it '商品の説明が空では保存できない' do
        @item.information = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Information can't be blank")
      end

      it '価格が空では保存できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end

      it '価格は半角数字ではないと、保存できない' do
        @item.price = '４５５５５５５'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price Half-width number')
      end

      it '価格が300未満であれば保存できない' do
        @item.price = '299'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price Out of setting range')
      end

      it '価格が9999999を超過あうあると保存できない' do
        @item.price = '10000000'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price Out of setting range')
      end

      it 'カテゴリーを一つ選ばないと、保存できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Category Select')
      end

      it '商品の状態を一つ選ばないと、保存できない' do
        @item.item_condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Item condition Select')
      end

      it '配送料の負担を一つ選ばないと、保存できない' do
        @item.delivery_charge_pay_method_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Delivery charge pay method Select')
      end

      it '配送元のを一つ選ばないと、保存できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Prefecture Select')
      end

      it '配送までの日数を一つ選ばないと、保存できない' do
        @item.scheduled_delivery_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Scheduled delivery Select')
      end
    end
  end
end
