class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


         with_options presence:true do
          validates :nickname

          validates :password,format:{with:/\A(?=.*?[a-z])(?=.*?[A-Z])(?=.*?[\d])\w{6,}\z/, message: 'には半角６文字以上、大文字、小文字、英数字を混ぜてください'}

          with_options format:{with:/\A[ぁ-んァ-ヶ一-龥々]+\z/, message: 'には日本語を使用してください'} do
            validates :first_name   
            validates :last_name       
          end

          with_options format:{with:/\A[ァ-ヶ]+\z/, message:'には全角カナもじを使用してください'} do
            validates :first_name_kana
            validates :last_name_kana
          end

          validates :birthday

        end
  has_many :items
end