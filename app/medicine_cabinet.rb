
def save_strain_to_medicine_cabinet(strain_name, strain_id)
    MedicineCabinetItem.create(user_id: $current_user.id, strain_name: strain_name, strain_id: strain_id, my_description: nil, rating: nil)
end


def save_strain_to_cabinet_w_details
    puts "What's the name of the strain?"

    strain_name = gets.chomp.downcase
    formatted_name = strain_name.split(' ').map{|word| word.capitalize}.join(' ')
    strain_id = find_strain_id_by_name_master_list(strain_name)

    desc = description_entry
    rating = rating_entry
   
    MedicineCabinetItem.create(user_id: $current_user.id, strain_name: formatted_name, strain_id: strain_id, my_description: desc, rating: rating)
    puts "This strain has been added to you Medicine Cabinet!"
end

def save_strain_to_cabinet_w_details_from_search(strain_name, strain_id)
    strain_name 
    formatted_name = strain_name.split(' ').map{|word| word.capitalize}.join(' ')
    # strain_id = find_strain_id_by_name_master_list(strain_name)
    desc = description_entry
    rating = rating_entry
   
    MedicineCabinetItem.create(user_id: $current_user.id, strain_name: formatted_name, strain_id: strain_id, my_description: desc, rating: rating)
    
    puts "This strain has been added to you Medicine Cabinet!"
end

def rating_entry
    puts "Leave a rating?"

    reply3 = gets.chomp.downcase
    rating = nil
    case reply3
    when "yes"
        puts "What's your opinion on a scale from -10 to 10?"
        input = gets.chomp
        rating = input.to_i
    when "no"
        rating = 0
        puts "All Right. Thats all. One moment while we make those changes."
    end 
    rating 
end 

def description_entry
    puts "Leave a description entry?"

    reply2 = gets.chomp.downcase
    desc = ""
    case reply2
    when "yes"
        puts "How would you describe it?"
        desc = gets.chomp.downcase
    when "no"
        desc = "no description"
    end 
    desc
end 
