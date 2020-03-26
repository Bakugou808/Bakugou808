def update_medicine_cabinet
    puts "What task would you like to perform? (enter the task number)"
    puts "1. Add a strain"
    puts "2. Change a description"
    puts "3. Change a rating"
    puts "4. Delete a strain"
    puts "5. View Inventory"
    puts "6. Exit Session"

    response = gets.chomp.downcase
    
    case response
    when "1"
        add_strain
    when "2"
        change_description
    when "3"
        change_rating
    when "4"
        delete_strain_record
    when "5"
        view_everything_about_my_strains
    when "6"
        exit_session
    end 
end

#*********
#*********
def find_record_in_cabinet_table(strain_name)
    MedicineCabinetItem.find_by(strain_name: strain_name)
end

def updated!(strain_record) 
    puts "We've updated your rating!"
    puts "Strain: #{strain_record[:strain_name]}"
    puts "Rating: #{strain_record[:rating]}"
    puts "Description: #{strain_record[:my_description]}"
    puts "Updated on #{strain_record[:updated_at]}"
end 

#save/create/add strain
def add_strain
    puts "What strain would you like to add to your Cabinet?"
    puts "Would you like to search the database?"
    reply = gets.chomp.downcase
    case reply
    when "yes" || "search"
        search_options
    when "no"
        puts "Okay, lets add your strain details."
        save_strain_to_cabinet_w_details
    end
    what_now?
end 

#delete method

def delete_options
    puts "1. Would you like to remove a strain from your cabinet?" 
    puts "2. Or empty your cabinet of all strains?"
    input = gets.chomp

    case input
    when "1"
        delete_strain_record
    when "2"
        destroy_all_records
    end
    what_now_bar
    what_now?
    what_now_bar
end

def delete_strain_record
    puts "Which strain would you like to delete?"
    view_my_strains
    strain = gets.chomp.downcase
    formatted_name = strain.split(' ').map{|word| word.capitalize}.join(' ')
    strain_record = find_record_in_cabinet_table(formatted_name)

    MedicineCabinetItem.delete_by(strain_name: formatted_name)

    puts "That strain has been removed from you Cabinet."
    line_breaks
    what_now_bar
    what_now?
    what_now_bar
end 



#update methods


def change_rating
    puts "Which strain would you like to update?"
    view_my_strains
    strain = gets.chomp.downcase
    formatted_name = strain.split(' ').map{|word| word.capitalize}.join(' ')
    strain_record = find_record_in_cabinet_table(formatted_name)

    puts "What's your rating from -10 to 10?"
    input = gets.chomp
    new_rating = input.to_i 

    strain_record.update(rating: new_rating)

    updated!(strain_record)
    what_now_bar
    what_now?
    what_now_bar
end



def change_description
    puts "Which strain would you like to update?"
    view_my_strains
    strain = gets.chomp.downcase
    formatted_name = strain.split(' ').map{|word| word.capitalize}.join(' ')
    strain_record = find_record_in_cabinet_table(formatted_name)

    puts "How was your experience?"
    new_description = gets.chomp

    strain_record.update(my_description: new_description)

    updated!(strain_record)

    what_now_bar
    what_now?
    what_now_bar

end


# t.integer :user_id
# t.string :strain_name
# t.integer :strain_id
# t.string :my_description
# t.integer :rating 