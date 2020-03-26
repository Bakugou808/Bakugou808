#get data based off strain id


def get_description_by_id(strain_id)
    api_key = "l7yuhjl"
    response_string = RestClient.get("strainapi.evanbusse.com/#{api_key}/strains/data/desc/#{strain_id}")
    parsed_arr = JSON.parse(response_string)
    desc = parsed_arr["desc"]
    puts desc
end
  
def get_effects_by_id(strain_id)
    api_key = "l7yuhjl"
    response_string = RestClient.get("strainapi.evanbusse.com/#{api_key}/strains/data/effects/#{strain_id}")
    parsed_arr = JSON.parse(response_string)
    puts "Positive Effects:"
    puts parsed_arr["positive"].join(", ")
    puts "Negative Effects:"
    puts parsed_arr["negative"].join(", ")
    puts "Medical Usages:"
    puts parsed_arr["medical"].join(", ")
end
  
def get_flavors_by_id(strain_id)
    api_key = "l7yuhjl"
    response_string = RestClient.get("strainapi.evanbusse.com/#{api_key}/strains/data/flavors/#{strain_id}")
    parsed_arr = JSON.parse(response_string)
    puts "Flavors"
    puts parsed_arr.join(" + ")
end
  