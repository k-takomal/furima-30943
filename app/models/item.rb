class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :postage
  belongs_to :area
  belongs_to :day

  validates :name,:text,:price, presence: true

  validates :category,:condition,:postage,:area,:day,numericality:{ othre_than: 0}

end
