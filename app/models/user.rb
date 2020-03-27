class User < ActiveRecord::Base
    has_many :medicine_cabinet_items
    has_many :cannabis_strain_ids, through: :medicine_cabinet_items
      
    def self.authenticate(user, password)
        if User.find_by(name: "#{user}") && User.find_by(name: "#{user}").password == password 
            current_user = User.find_by(password: "#{password}")
            $current_user = current_user
            true
        else
            false
        end 
    end 

    def self.verify(user, password)
        if User.find_by(password: "#{password}") == password
            puts "Sorry it looks like that password is taken! Try Another!"
            false
        elsif User.find_by(name: "#{user}") == user 
            puts "Sorry it looks like that name is taken! Try another!"
            false
        else
            true
        end 
    end


    
    def my_cabinet
        MedicineCabinetItem.find_each(user_id: $current_user.id)
    end

    

end

