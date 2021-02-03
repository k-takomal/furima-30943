class ItemAddress
  include ActiveModel::Model
  attr_accessor :postal_code,:area_id,:cities,:house_number,:building_name,:tel,:token,:order,:order_id,:user_id,:item_id

  with_options presence:true do   
    validates :postal_code,  format:{with: /\A\d{3}[-]\d{4}\z/, message: "はハイフン（-）を含めた７桁の半角数字にしてください"}
    validates :area_id, numericality:{ other_than: 0} 
    validates :cities, format:{with: /\A[ぁ-んァ-ン一-龥々]/, message: "は日本語入力してください"}
    validates :house_number, presence:true
    
    validates :tel ,format:{with: /0{1}\d{9,10}/,message: "はハイフンなしの０から始まる１０〜１１桁の半角数字で記入してください"} 
    validates :token

  end 

  def save
    order = Order.create(user_id: user_id, item_id: item_id,token: token )
    Address.create(postal_code: postal_code,area_id: area_id,cities: cities,house_number: house_number,building_name: building_name,tel: tel, order_id: order.id)
  end
end