require 'rest-client' 
require 'json'
require 'pry'

#query by name 

def get_info_by_name(strain_name)
  strain_name = strain_name
  formatted_name = URI.escape(strain_name)
  api_key = "l7yuhjl"
  response_string = RestClient.get("strainapi.evanbusse.com/#{api_key}/strains/search/name/#{formatted_name}")
  parsed_arr = JSON.parse(response_string)

  if parsed_arr.length == 0
    no_data 
  elsif parsed_arr.length == 1
    strain_id = parsed_arr[0]["id"]    
    puts final = "Name: #{parsed_arr[0]["name"]}.\nRace: #{parsed_arr[0]["race"]}.\nDescription: #{parsed_arr[0]["desc"]}"
    line_breaks
    more_info?(strain_id, strain_name)
  else
    organize_strain_list(parsed_arr)
  end 
end

def more_info?(strain_id, strain_name)
  line_breaks
  puts "Enter 'effects' to see what it does and the conditions it treats. Enter 'flavor' to see how it tastes. Enter 'all' to see both. Enter 'save' to add this strain to your Medicine Cabinet. Enter 'search' to return to the search menu."
  line_breaks
  puts "If you'd like to exit enter any key."
  line_breaks
  response = gets.chomp.downcase
  puts "\n"
  case response 
  when "effects"
    get_effects_by_id(strain_id)
    paragraph_breaks
    more_info?(strain_id, strain_name)
  when "flavor"
    get_flavors_by_id(strain_id)
    paragraph_breaks
    more_info?(strain_id, strain_name)
  when "all"
    get_effects_by_id(strain_id)
    paragraph_breaks
    get_flavors_by_id(strain_id)
    paragraph_breaks
    more_info?(strain_id, strain_name)
    exit_session
  when "save"
    paragraph_breaks
    save_strain_to_cabinet_w_details_from_search(strain_name, strain_id)
    what_now_bar
    what_now?
    what_now_bar
  when "search"
    search_options
  when "exit"
    exit_session
  else
    puts "I didn't quiet get that... too much flower? Lets start at the beginning."
    search_options
  end
end

def organize_strain_list(json_arr)
  list_names = json_arr.map{|strain_info| strain_info["name"]}
  puts "Matching Strains!"
  paragraph_breaks
  puts list_names
  puts "Cannabis has many varieties. Type the name of the strain to learn more!"
  selected_strain = gets.chomp
  paragraph_breaks
  get_info_by_name(selected_strain)
end

#list of strains, flavors, effects, and phylums available

def list_of_strain_names
  api_key = "l7yuhjl"
  response_string = RestClient.get("strainapi.evanbusse.com/#{api_key}/strains/search/all")
  parsed_arr = JSON.parse(response_string)
  list_of_strains = parsed_arr.keys
  hash_of_name_groups = list_of_strains.group_by { |name| name[0] } 
end 

def all_strain_names_and_id
  api_key = "l7yuhjl"
  response_string = RestClient.get("strainapi.evanbusse.com/#{api_key}/strains/search/all")
  parsed_hash = JSON.parse(response_string)
  names_id_hash = {}
  parsed_hash.map{|strain_name, subhash| names_id_hash[strain_name] = subhash["id"]}
  names_id_hash
end


def find_strain_id_by_name_master_list(strain_name)
  names_and_id_hash = all_strain_names_and_id
  result = names_and_id_hash.select{|name, id| name == strain_name} 
  result.values if !result.empty?
  absent = 0
end 

def flavor_list
  paragraph_breaks
  api_key = "l7yuhjl"
  response_string = RestClient.get("strainapi.evanbusse.com/#{api_key}/searchdata/flavors")
  parsed_arr = JSON.parse(response_string)
end 

def effects_list
  paragraph_breaks
  api_key = "l7yuhjl"
  response_string = RestClient.get("strainapi.evanbusse.com/#{api_key}/searchdata/effects")
  parsed_arr = JSON.parse(response_string)
  effects_list_arr = parsed_arr.map{|strain| strain["effect"]}.uniq
end 

def phylum_list
  paragraph_breaks
  line_breaks
  pylum = ["Sativa", "Hybrid", "Indica"]
end 