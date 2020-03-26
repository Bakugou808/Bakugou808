class MedicineCabinetItem < ActiveRecord::Base
    belongs_to :user
    belongs_to :cannabis_strain_id
      
    def self.rating_over_7
        list = MedicineCabinetItem.where('rating > ?', 6)
    end
    
    
end