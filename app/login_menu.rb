#puts welcome message
def welcome
    main_menu_heading
    puts "Welcome to our program!"
    line_breaks
    puts "Would you like to log in or sign up?"
    line_breaks
    response = gets.chomp.downcase
    case response
    when "log in"
      login
    when "sign up"
      signup
    when "exit"
      exit_now
    when "quit"
      exit_now
    else
      puts "I'm not sure what you mean there"
      welcome
    end
end

def main_menu
  main_menu_heading
  puts "Would you like to Search or View?"
  line_breaks
  puts "Enter 'search' or 'view' or 'exit'"
  response = gets.chomp.downcase
  line_breaks

  case response
  when "search"
      line_breaks
      search_options
      line_breaks
  when "view"
      line_breaks
      view_menu
      line_breaks
  when "exit"
      exit_now
  else
      "I didn't quit get that."
      main_menu 
  end
end 

def login                                                     
  puts "What's your Username?"
  username = gets.chomp.downcase
  puts "What's your Password?"
  password = gets.chomp.downcase
  if User.authenticate(username, password)
    main_menu
  else
    puts "That didn't seem to work. Would you like to try again?(yes/no)"
    response = gets.chomp.downcase
    case response
    when "yes"
      login
    when "no" 
      welcome
    end
  end 
end

def signup
  puts "Please enter a Username"
  username = gets.chomp.downcase
  puts "Please enter a Password"
  password = gets.chomp.downcase

  if User.find_by(name: "#{username}") == nil 
    User.create(name: username, password: password)
  else
    puts "Sorry, that Username is taken. Try a different one."
    signup
  end
  User.authenticate(username, password)
  main_menu
end