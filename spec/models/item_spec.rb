require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品機能' do

    context '商品出品がうまく行くとき' do

      it "画像が選択されている、商品名が４０字以内で存在、商品の説明文が１０００字いないで存在、カテゴリー、商品の状態、発送料の負担、発送元の地域、発送までの日数が選択されている、販売価格に３００〜９９９９９９９までの数値が存在する" do
        expect(@item).to be_valid
      end

      it "商品名が４０字以内"do
      @item.name = "a"*40
      expect(@item).to be_valid
      end
      it "商品の説明が１０００字以内"do
      @item.text = "a"*1000
      expect(@item).to be_valid
      end
    end

    context '商品出品がうまく行かないとき' do

      it "商品画像が付いていない" do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it "商品名がない" do
        @item.name = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      it "商品名が４０文字以上" do
        @item.name = "a"*41
        @item.valid?
        expect(@item.errors.full_messages).to include("Name is too long (maximum is 40 characters)")
      end
      it "商品の説明がない" do
        @item.text = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Text can't be blank")
      end
      it "商品の説明が１０００文字以上" do
        @item.text = "a"*1001
        @item.valid?
        expect(@item.errors.full_messages).to include("Text is too long (maximum is 1000 characters)")
      end
      it "カテゴリーが選択されていない" do
        @item.category_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Category must be other than 0")
      end
      it "商品の状態についてが選択されていない" do
        @item.condition_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition must be other than 0")
      end
      it "配送料の負担についてが選択されていない" do 
        @item.postage_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Postage must be other than 0")
      end
      it "発送元の地域についてが選択されていない" do
        @item.area_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Area must be other than 0")
      end
      it "発送までの日数についてが選択されていない" do 
        @item.day_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Day must be other than 0")
      end
      it "価格が記入されていない" do
        @item.price = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank", "Price is not a number")
      end
      it "価格が、¥300 以下" do
        @item.price = "299"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be greater than 300")
      end
      it "価格が、¥9,999,999 以上" do
        @item.price = "10000000"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be less than 9999999")
      end
      it "販売価格が半角数字以外（英字）" do
        @item.price = "aaa"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end
      it "販売価格が半角数字以外（日本語）" do
        @item.price = "三百"
        @item.valid?
        expect(@item.errors.full_messages).to include( "Price is not a number")
      end
      it "販売価格が半角数字以外（全角数字）" do
        @item.price = "３００"
        @item.valid?
        expect(@item.errors.full_messages).to include( "Price is not a number")
      end
    end
  end
end
