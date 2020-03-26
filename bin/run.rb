require_relative "../config/environment.rb"

title_header
menu_bar

welcome
puts "Would you like to Search or View?"
response = gets.chomp.downcase

case response
when "search"
    search_options
when "view"
    view_menu
else
    "I didn't quit get that."
    return 
end