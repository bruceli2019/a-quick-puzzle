class PagesController < ApplicationController
  def puzzle
    @curr_guess = session[:user_input]
    @all_results = session[:results]
    render("pages/puzzle.html.erb")
  end
  
  def record_guess
    #store info on user browser with cookies -- Rails hash that is automatically created
    
    #recall this is how we add a key-vaue pair to a hash
    # cookies[:key] = value
    # session[:key] = value
    
    # we first check if the rule is fulfilled -- if the first < second < third, we display yes; display no otherwise
    first = params.fetch("first").to_i
    second = params.fetch("second").to_i
    third = params.fetch("third").to_i
    
    # use && instead of and -- && has higher precedence over and
    if((first < second) && (second < third))
      result = "Yes!"
    else
      result = "No"
    end
    
    # plan- we create an array of values
    new_array = Array.new
    
    #we add the 3 user values to the new_array as well as the result into this array
    new_array.push(first)
    new_array.push(second)    
    new_array.push(third)
    new_array.push(result)
    
    #combine the existing array of user values with the new user input
    # Note that cookies can't store complex data structures - it flattens everything into a string
    # sessions can store complex data structures, like arrays
    existing_user_input = session[:user_input]
    
    #condition - if there is no existing array in the user_input hash, we create the new array and set that equal to the new_array
    # we do an array of array -- that way we can have 3 each do loops and know where to end
    if existing_user_input.nil?
      existing_user_input = Array.new
      existing_user_input.push(new_array)
    else
      existing_user_input.push(new_array)
    end
    
    #restore that into the session
    session[:user_input] = existing_user_input
    
    redirect_to("/a-quick-puzzle")
  end
  
end
