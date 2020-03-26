class CannabisStrainId < ActiveRecord::Base
    has_many :medicine_cabinet_items
    has_many :users, through: :medicine_cabinet_items 
      
    
    
end