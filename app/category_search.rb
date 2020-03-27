require 'rest-client' 
require 'json'
require 'pry'




#search by category

#request data from API by category

def get_strains_by_flavor(flavor)
    formatted_flavor = URI.escape(flavor)
    api_key = "l7yuhjl"
    response_string = RestClient.get("strainapi.evanbusse.com/#{api_key}/strains/search/flavor/#{formatted_flavor}")
    parsed_arr = JSON.parse(response_string)
    matching_strains_arr = parsed_arr.map{|strain| strain["name"]}.uniq
    alpha_hash = matching_strains_arr.group_by { |name| name[0] } 
  
    if alpha_hash.length == 0
      no_matching_flavor
    else
      puts_alpha_hash(alpha_hash)
      get_strain_name_from_user_and_search
    end 
end

def get_strains_by_effect(effect)
    formatted_effect = URI.escape(effect)
    api_key = "l7yuhjl"
    response_string = RestClient.get("strainapi.evanbusse.com/#{api_key}/strains/search/effect/#{formatted_effect}")
    parsed_arr = JSON.parse(response_string)
    matching_strains_arr = parsed_arr.map{|strain| strain["name"]}.uniq
    alpha_hash = matching_strains_arr.group_by { |name| name[0] } 
  
    puts_alpha_hash(alpha_hash)
    get_strain_name_from_user_and_search
end
  
def get_strains_by_phylum(phylum)
    api_key = "l7yuhjl"
    response_string = RestClient.get("strainapi.evanbusse.com/#{api_key}/strains/search/race/#{phylum}")
    parsed_arr = JSON.parse(response_string)
    matching_strains_arr = parsed_arr.map{|strain| strain["name"]}.uniq
    phylum_hash = matching_strains_arr.group_by { |name| name[0] } 
    
    puts_alpha_hash(phylum_hash)
    get_strain_name_from_user_and_search
end
  

#output helper method

def puts_alpha_hash(list)
    puts "What alphabetical character would you like to search through?"
    character = gets.chomp.upcase
    alpha_hash = list

    if alpha_hash[character] == nil 
        line_breaks
        puts "Sorry No strains in that character directory." 
        line_breaks
    else
        puts alpha_hash[character] 
    end 
    
    puts "See more?\n"
    puts "enter 'yes' or 'no'"
    line_breaks
    reply = gets.chomp.downcase
    line_breaks
    puts "\n"
    case reply 
    when "yes"
        puts_alpha_hash(alpha_hash)
    when "no"
        puts "Back to search menu? Or continue with search? ('menu'/'continue')"
        response = gets.chomp.downcase
        case response
        when "menu"
            search_options
        when "continue"
            return 
        end 
    when "exit"
        goodbye
    else
        puts "search through the catalog?"
        response = gets.chomp.downcase
        case response
        when "no"
            return
        when "yes"
            puts_alpha_hash(alpha_hash)
        else
            line_breaks
            puts "YOU'RE STONED BRUH"
            exit_session 
        end
    end
end
  