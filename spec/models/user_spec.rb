require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do

    context 'ユーザー登録がうまく行く時' do

      it "ニックネーム、メールアドレス、パスワード（＋確認）、お名前（姓、名）、お名前カナ（姓、名）、生年月日 があるとき" do
        expect(@user).to be_valid
      end

      it "パスワードが６文字以上、半角英数字混合の時" do
        @user.password = "AAbb11"
        @user.password_confirmation = "AAbb11"
         expect(@user).to be_valid
      end

    end
    
    context 'ユーザー登録がうまくいかない時' do

      it "ニックネームが空だと登録できない" do
        @user.nickname = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it "メールアドレスが空だと登録できない" do
        @user.email = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it "メールアドレスは一意性がなければ登録できない" do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Email has already been taken")
      end

      it "メールアドレスは、@を含まなければ登録できない" do
        @user.email = "aaayahoo.co.jp"
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end

      it "パスワードが空だと登録できない" do
        @user.password = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it "パスワードは、6文字以下だと登録できない" do
        @user.password = "aA1aA"
        @user.password_confirmation = "aA1aA"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end

      it "パスワードは、半角英数字混合での入力でなければ登録できない" do
        @user.password = "aaa111"
        @user.password_confirmation = "aaa111"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password には半角６文字以上、大文字、小文字、英数字を混ぜてください")
      end

      it "パスワードは、確認用を含めて2回入力しなければ登録できない" do
        @user.password_confirmation = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it "パスワードとパスワード（確認用）の値が一致しなければ登録できない" do
        @user.password = "AAbb11"
        @user.password_confirmation = "BBaa11"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it "ユーザー本名は、名字が空だと登録できない" do
        @user.last_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end

      it "ユーザー本名は、名前が空だと登録できない" do
        @user.first_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end

      it "ユーザー本名(名字)は、全角（漢字・ひらがな・カタカナ）での入力でなければ登録できない" do
        @user.last_name = "ABE"
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name には日本語を使用してください")
      end 

      it "ユーザー本名（名前）は、全角（漢字・ひらがな・カタカナ）での入力でなければ登録できない" do
        @user.first_name = "ABE"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name には日本語を使用してください")
      end 

      it "ユーザー本名のフリガナは、名字が空だと登録できない" do
        @user.last_name_kana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end

      it "ユーザー本名のフリガナは、名前が空だと登録できない" do
        @user.first_name_kana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end

      it "ユーザー本名（名字）のフリガナは、全角（カタカナ）での入力でなければ登録できない" do
        @user.last_name_kana = "あべ"
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana には全角カナもじを使用してください")
      end

      it "ユーザー本名（名前）のフリガナは、全角（カタカナ）での入力でなければ登録できない" do
        @user.first_name_kana = "あべ"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana には全角カナもじを使用してください")
      end

      it "生年月日がなければ登録できない" do
        @user.birthday = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end

      # 追加テスト
      it "パスワードは、半角英字のみでは登録できないこと" do
        @user.password = "abcdef"
        @user.password_confirmation = "abcdef"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password には半角６文字以上、大文字、小文字、英数字を混ぜてください")
      end

      it "パスワードは、半角数字のみでは登録できないこと" do
        @user.password = "123456"
        @user.password_confirmation = "123456"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password には半角６文字以上、大文字、小文字、英数字を混ぜてください")
      end

      it "パスワードは、全角文字では登録できないこと" do
        @user.password = "ABCDEF"
        @user.password_confirmation = "ABCDEF"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password には半角６文字以上、大文字、小文字、英数字を混ぜてください")
      end

    end
  end
end
