class CreateCannabisStrainIds < ActiveRecord::Migration[6.0]
  def change
    create_table :cannabis_strain_ids do |t|
        t.string :name
        t.integer :strain_id
        t.timestamps
    end 
  end
end
