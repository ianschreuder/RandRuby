class CreateLocationTable < ActiveRecord::Migration
  def change
    create_table :facilities do |t|
      t.string :prov_num
      t.string :name
      t.timestamps
    end

    create_table :locations do |t|
      t.integer :facility_id
      t.string :street
      t.string :city
      t.string :state
      t.string :zip
      t.string :phone
      t.float :lat
      t.float :lng

      t.timestamps
    end

  end
end
