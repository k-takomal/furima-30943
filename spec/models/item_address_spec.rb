require 'rails_helper'

RSpec.describe ItemAddress, type: :model do
  before do
    @user1 = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user)
    @item1 = FactoryBot.create(:item)
    @order = Order.create()
    @address = FactoryBot.build(:item_address,order:@order,user_id: @user1.id,item_id: @item1.id)
    sleep(1)
  end
  
  
  describe "商品購入機能" do
    
    context "商品が購入できるとき" do
      
      it "必要な情報を適切に入力すると、商品の購入ができる" do
        expect(@address).to be_valid
      end
      it "建物名がなくても商品の購入ができる" do
        @address.building_name = ""
        expect(@address).to be_valid
      end
    end
    
    context "商品が購入できないとき" do
      
      it "クレジットカード情報（token）がない"do
      @address.token = nil
      @address.valid? 
      expect(@address.errors.full_messages).to include("Token can't be blank")
      end
      it "user_idがない"do
      @address.user_id = nil
      @address.valid? 
      expect(@address.errors.full_messages).to include("User can't be blank")
      end
      it "item_idがない"do
      @address.item_id = nil
      @address.valid? 
      expect(@address.errors.full_messages).to include("Item can't be blank")
      end
      
      it "郵便番号が入力されていない"do
      @address.postal_code = nil
      @address.valid?
      expect(@address.errors.full_messages).to include("Postal code can't be blank")
      end

      it "郵便番号にハイフンが含まれていない（1234567）"do
      @address.postal_code = 1234567
      @address.valid?
      expect(@address.errors.full_messages).to include("Postal code はハイフン（-）を含めた７桁の半角数字にしてください")
      end

      it "郵便番号が８桁以上（1234-5678）"do
      @address.postal_code = 1234-5678
      @address.valid?
      expect(@address.errors.full_messages).to include("Postal code はハイフン（-）を含めた７桁の半角数字にしてください")
      end

      it "郵便番号が８桁以上（123-45678）"do
      @address.postal_code = 123-45678
      @address.valid?
      expect(@address.errors.full_messages).to include("Postal code はハイフン（-）を含めた７桁の半角数字にしてください")
      end
      it "郵便番号がハイフンが6桁以下（123-456）"do
      @address.postal_code = 123-456
      @address.valid?
      expect(@address.errors.full_messages).to include("Postal code はハイフン（-）を含めた７桁の半角数字にしてください")
      end
      
      it "郵便番号がハイフンが6桁以下（12-3456）"do
      @address.postal_code = 12-3456
      @address.valid?
      expect(@address.errors.full_messages).to include("Postal code はハイフン（-）を含めた７桁の半角数字にしてください")
      end

      it "郵便番号に全角数字が使われている（１２３－４５６７）"do
      @address.postal_code = "１２３－４５６７"
      @address.valid?
      expect(@address.errors.full_messages).to include("Postal code はハイフン（-）を含めた７桁の半角数字にしてください")
      end

      it "郵便番号に半角英字が使われている（abc-defg）"do
      @address.postal_code = "abc-defg"
      @address.valid?
      expect(@address.errors.full_messages).to include("Postal code はハイフン（-）を含めた７桁の半角数字にしてください")
      end
      it "郵便番号に日本語が使われている（郵便番号）"do
      @address.postal_code = "郵便番号"
      @address.valid?
      expect(@address.errors.full_messages).to include("Postal code はハイフン（-）を含めた７桁の半角数字にしてください")
      end
      it "都道府県が選択されていない（--を選択）"do
      @address.area_id = 0
      @address.valid?
      expect(@address.errors.full_messages).to include("Area must be other than 0")
      end
      it "市区町村が入力されていない"do
      @address.cities = ""
      @address.valid?
      expect(@address.errors.full_messages).to include("Cities can't be blank", "Cities は日本語入力してください")
      end
      it "市区町村に半角英字が使われている（katusikaku）"do
      @address.cities = "katusikaku"
      @address.valid?
      expect(@address.errors.full_messages).to include("Cities は日本語入力してください")
      end
      it "市区町村に全角英字が使われている（ｋａｔｕｓｉｋａｋｕ）"do
      @address.cities = "ｋａｔｕｓｉｋａｋｕ"
      @address.valid?
      expect(@address.errors.full_messages).to include("Cities は日本語入力してください")
      end
      
      it "番地が入力されていない"do
      @address.house_number = ""
      @address.valid?
      expect(@address.errors.full_messages).to include("House number can't be blank")
      end
      it "電話番号が入力されていない"do
      @address.tel = ""
      @address.valid?
      
      expect(@address.errors.full_messages).to include("Tel can't be blank")
      end
      it "電話番号にハイフンが含まれている（01-2345-6789）"do
      @address.tel = 01-2345-6789
      @address.valid?
      expect(@address.errors.full_messages).to include("Tel はハイフンなしの０から始まる１０〜１１桁の半角数字で記入してください")
      end
      
      it "電話番号が0以外で始まっている（1234567890）"do
      @address.tel = 1234567890
      @address.valid?
      expect(@address.errors.full_messages).to include("Tel はハイフンなしの０から始まる１０〜１１桁の半角数字で記入してください")
      end      

      it "電話番号が全角数字で書かれている（０１２３４５６７８９０）"do
      @address.tel = "０１２３４５６７８９０"
      @address.valid?
      expect(@address.errors.full_messages).to include("Tel はハイフンなしの０から始まる１０〜１１桁の半角数字で記入してください")
      end
      it "電話番号が英数混合で書かれている"do
      @address.tel = "0123abc456"
      @address.valid?
      expect(@address.errors.full_messages).to include("Tel はハイフンなしの０から始まる１０〜１１桁の半角数字で記入してください")
      end
      
      
    end
  end

end
