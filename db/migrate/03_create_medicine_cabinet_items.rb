class CreateMedicineCabinetItems < ActiveRecord::Migration[6.0]
  def change
    create_table :medicine_cabinet_items do |t|
        t.integer :user_id
        t.string :strain_name
        t.integer :strain_id
        t.string :my_description
        t.integer :rating 
        t.timestamps
    end 
  end
end
