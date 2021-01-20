class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :postage
  belongs_to :area
  belongs_to :day
  

  belongs_to :user
  has_one_attached :image
   
  validates :name,:text,:price, presence: true

  validates :category_id,:condition_id,:postage_id,:area_id,:day_id,numericality:{ othre_than: 0}

end
