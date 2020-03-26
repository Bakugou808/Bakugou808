def search_options
    puts "How would you like to search this Database?"
    puts "Name? Effects? Flavor? Phylum?"
    response = gets.chomp.downcase
    if response == "name"
        get_strain_name_from_user_and_search
    elsif response == "effects"
        get_effect_from_user_and_search
    elsif response == "flavor"
        get_flavor_from_user_and_search
    elsif response == "phylum"
        get_phylum_from_user_and_search
    elsif response == "exit"
        exit_session
    else
      puts "Please enter a valid response"
      search_options
    end
end


def get_strain_name_from_user_and_search
    puts "Please enter a strain name"
    strain_name = gets.chomp.downcase.split(" ").map{|word| word.capitalize}.join(" ") 
    case strain_name
    when "exit"
        exit_now
    when "menu"
        search_options 
    end
    get_info_by_name(strain_name)
end
  
#helper methods for search_options

def get_phylum_from_user_and_search
    puts "Would you like to see a list of the different phylum?"
    response = gets.chomp.downcase
    case response
    when "yes"
        phylum_list.each{|phylum| puts phylum}
        search_phylum
    when "exit"
        return 
    when "no"
        search_phylum
    else
        puts "Sorry I didn't get that, one more time."
        get_phylum_from_user_and_search
    end
    
end

def search_phylum
    puts "Please enter a phylum to see a list of matching strains."
    selected = gets.chomp.downcase
    formatted = selected.split(' ').map{|word| word.capitalize}.join(' ')

    if phylum_list.include?(formatted)
        get_strains_by_phylum(selected)
    elsif selected == "exit"
        exit_now
    else 
        puts "Lets try again."
        search_phylum
    end
end 

def get_flavor_from_user_and_search
    puts "Would you like to see a list of flavors?"
    response = gets.chomp.downcase
    case response
    when "yes"
        flavor_list.each{|flavor| puts flavor}
    when "exit"
        return 
    end
    puts "Please enter a flavor to see a list of matching strains."
    selected = gets.chomp.downcase
    formatted = selected.split(' ').map{|word| word.capitalize}.join(' ')

    if flavor_list.include?(formatted)
        get_strains_by_flavor(selected)
    elsif selected == "exit"
        exit_now 
    else
        puts "Sorry lets try again."
        get_flavor_from_user_and_search
    end
end

def get_effect_from_user_and_search
    puts "Would you like to see a list of effects & treatments?"
    response = gets.chomp.downcase
    case response
    when "yes"
        effects_list.each{|effect| puts effect}
        search_effect
    when "exit"
        return 
    when "no"
        search_effect
    else
        puts "Mmmhh didn't quite get that. One more time."
        get_effect_from_user_and_search
    end
end 

def search_effect 
    puts "Please enter an effect/treatment to see a list of matching strains."
    selected = gets.chomp.downcase
    formatted = selected.split(' ').map{|word| word.capitalize}.join(' ')

    if effects_list.include?(formatted)
        get_strains_by_effect(selected)
    elsif selected == "exit"
        exit_now
    else 
        puts "Lets try again."
        search_effect
    end
end

#error responses

def no_data
    puts "There is no information on this strain. They must have been stoned when they built it... Would you like to try again, or maybe take a look at our list of strains? ('show list'/'try again')"
    response = gets.chomp.downcase
    case response
    when "show list"
        puts_alpha_hash(list_of_strain_names)
        get_strain_name_from_user_and_search
    when "try again"
        get_strain_name_from_user_and_search
    else
        return
    end
end

def no_matching_flavor
    puts "Looks like there aren't any strains with that description. Sorry about that! How about a different one?"
    get_flavor_from_user_and_search
end

