class Address < ApplicationRecord
  belongs_to :order
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :area

    # with_options presence: true do
    # validates :postal_code, format:{with: /\A\d{3}[-]\d{4}\z/, message: "はハイフン（-）を含めてください"}
    # validates :area_id, numericality:{ other_than: 0} 
    # validates :cities, format:{with: /\A[ぁ-んァ-ン一-龥々]/, message: "は日本語入力してください"}
    # validates :house_number
    
    # validates :tel ,format:{with: /0\d{9,10}/,message: "はハイフンなしで記入してください"} 
    # end


end
