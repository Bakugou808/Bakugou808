def view_menu
    main_menu_heading
    puts "Enter the task number you'd like to perform."
    puts "1. View My Medicine Cabinet"
    puts "2. Update My Medicine Cabinet"
    puts "3. Main Menu"
    puts "4. Exit Session"
    
    
    response = gets.chomp.downcase

    
    case response
    when "1"
        view_medicine_cabinet
    when "2"
        update_medicine_cabinet
    when "3"
        main_menu
    when "4"
        exit_session
    end 
     
end

#view medicine cabinet options: all, strains, my_descriptions, rating
def view_medicine_cabinet
    main_menu_heading
    puts "Enter the task number you'd like to perform."
    puts "1. View My Favorite Strains"
    puts "2. View My Descriptions"
    puts "3. View Strain Data"
    puts "4. View My Strains"
    puts "5. My Strain Profiles"
    puts "6. Want a blend?"
    puts "7. Go Back To Medicine Cabinet Menu"
    puts "Enter Exit to end the program"

    response = gets.chomp.downcase

    case response
    when "1"
        view_my_favorite_strains
        what_now_bar
        what_now?
        what_now_bar
    when "2"
        view_my_descriptions
        what_now_bar
        what_now?
        what_now_bar
    when "3"
        reply = "yes"
        while reply == "yes"
            view_strain_api_data
            puts "View more data?"
            reply = gets.chomp.downcase
        end 
        what_now_bar
        what_now?
        what_now_bar
    when "4"
        view_my_strains
        what_now_bar
        what_now?
        what_now_bar
    when "5"
        view_everything_about_my_strains
        what_now_bar
        what_now?
        what_now_bar
    when "6"
        give_blend
        what_now_bar
        what_now?
        what_now_bar
    when "7"
        view_menu
    else
        exit_now
    end

     
end

def what_now? #intermediatory method that directs user to different methods.
    return_info_heading
    puts "Back to Medicine Cabinet? or Main Menu? or Exit?"
    puts "Enter 'Cabinet' or 'Menu' or 'Exit'"
    return_info_heading
    response = gets.chomp.downcase

    case response
    when "cabinet"
        view_menu
    when "menu"
        main_menu
    when "exit"
        exit_now
    else
        puts "Lets try again."
        line_breaks
        what_now?
    end
end 

#returns current user id
def my_medicine_cabinet
    users_cabinet = MedicineCabinetItem.where(user_id: $current_user.id) #all strain objects in medicine cabinet
    users_cabinet
end 

#returns users strains, strain_id as an array

def users_strain_strain_ids
    strain_ids = my_medicine_cabinet.map{|strain_hash| "#{strain_hash[:strain_id]}"}
end

#convert strain name to strain_id
def find_strain_id_by_name_from_cabinet(strain_name)
    formatted_name = strain_name.split(' ').map{|word| word.capitalize}.join(' ')
    strain_id = my_medicine_cabinet.map{|strain_hash| strain_hash[:strain_id] if strain_hash[:strain_name] == formatted_name}.compact
    formatted_id = strain_id[0]
end
#view methods

def view_strain_api_data
    puts "What strain from your cabinet would you like to look up?"
    view_my_strains
    strain_name = gets.chomp.downcase
    formatted_name = strain_name.split(' ').map{|word| word.capitalize}.join(' ')
    formatted_id = find_strain_id_by_name_from_cabinet(strain_name)

    puts "Dope. What would you like to know?"
    puts "1. Online Description"
    puts "2. Flavors"
    puts "3. Effects/Medical Usages"

    selected = gets.chomp.downcase

    case selected 
    when "1"
        puts formatted_name
        paragraph_breaks
        get_description_by_id(formatted_id)
    when "2"
        puts formatted_name
        paragraph_breaks
        get_flavors_by_id(formatted_id)
    when "3"
        puts formatted_name
        paragraph_breaks
        get_effects_by_id(formatted_id)
    when "menu"
        view_menu
    when "main"
        main_menu
    else
        line_breaks
        puts "Lets try again."
        line_breaks
        view_strain_api_data
    end
end

def view_my_strains
    strain_names = my_medicine_cabinet.map{|strain_hash| "#{strain_hash[:strain_name]}"}
    main_menu_heading
    puts strain_names
    #in the save function add add_my_description method
end 

def view_my_descriptions
    strain_descriptions = my_medicine_cabinet#.map{|strain_hash| "#{strain_hash[:strain_name]}: #{strain_hash[:my_description]}"}
    strain_descriptions.each{|strain_hash| puts "#{strain_hash[:strain_name]}: Description = #{strain_hash[:my_description]}"}
end

def view_my_favorite_strains
    favorite_strains = MedicineCabinetItem.where('rating > ?', 6).map{|strain_hash| strain_hash if strain_hash[:user_id] == $current_user.id}
    list = favorite_strains.compact 
    if list.length > 0
        main_menu_heading
        list.each{|strain_hash| puts "#{strain_hash[:strain_name]}: Rating = #{strain_hash[:rating]}"}
    else
        line_breaks 
        puts "You don't have any ratings over 6 - guess you gotta find some more strains to smoke!"
        line_breaks
    end 
end 
#*****
def view_everything_about_my_strains
    all_details = my_medicine_cabinet
    main_menu_heading
    output = ""
    all_details.each{|strain_hash| output += "#{strain_hash[:strain_name]}: #{strain_hash[:rating]} \n*** Description: #{strain_hash[:my_description]}\n*** Last Updated: #{strain_hash[:updated_at]}\n\n"}
    puts output
end 

def give_blend
    object_hash_arr = my_medicine_cabinet
    strain1 = object_hash_arr.sample[:strain_name]
    strain2 = object_hash_arr.sample[:strain_name]
    line_breaks
    puts "Try a 60/40 blend of #{strain1} and #{strain2}"
    line_breaks
end