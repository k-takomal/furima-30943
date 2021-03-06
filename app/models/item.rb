class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :postage
  belongs_to :area
  belongs_to :day

  belongs_to :user
  has_one_attached :image
  has_many :orders 
  validates :name,:text,:price, :image,presence: true

  validates :name,length:{maximum: 40}
  validates :text,length:{maximum: 1000}
  validates :price, numericality:{greater_than: 299,less_than: 10000000}

  validates :category_id,:condition_id,:postage_id,:area_id,:day_id,numericality:{ other_than: 0}

end
