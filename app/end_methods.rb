#endsession

def exit_session 
    what_now_bar
    puts "Would you like to keep searching, go back to the menu or are you ready to smoke?"
    reply = gets.chomp.downcase
    case reply
    when "search"
      search_options
    when "menu"
      main_menu
    when "ready to smoke"
      goodbye
    else
      "Didn't quite get that... too stoned?"
      goodbye
    end
end

def exit_now
    goodbye
end

def goodbye
    title_header
    ready_to_smoke_heading
    puts "Thanks for stopping in! See you next time!"  
    exit 
end