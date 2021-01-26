class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.string     :postal_code,    null: false       
      t.integer    :area_id,        null: false       
      t.string     :cities,         null: false       
      t.string     :house_number,   null: false       
      t.string     :building_name                       
      t.string     :tel,            null: false       
      t.references  :order,          foreign_key: true 

      t.timestamps
    end
  end
end
