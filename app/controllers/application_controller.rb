class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  ## Methods created in ApplicationController is they are available in all other controllers but not in views
  ## Ability to retrieve the current user., make a chef user accessible only to his/her recipe
  # Is  the user trying to perform an action currently logged in?
  
  # To make methods in ApplicationController available to views, we define the following:
  helper_method :current_user, :logged_in?  # this makes the set methods available
  
  
  # check if the current user is the creator of the recipe?
  def current_user 
    #if session's chef_id is set/defined, find chef based on its id and stores it in the @current_user instance var which is a memory var
    #the ||= when used,subsequent call to methof current_user wont hit the database for find again, it will just use the @current_user memory var
    #tis is good for efficiency  
    @current_user ||= Chef.find(session[:chef_id]) if session[:chef_id]
  end
  
  #is the user logged in or not?
  def logged_in?
    ## to query if the logged in, call the current_user with !! preceeded, this turns it to true or false
    # TRUE or FALSE
    !!current_user
  end
  
  def require_user 
    if !logged_in?
      flash[:danger] = "You must be logged in to perform that action"
      redirect_to recipes_path
    end
  end
  
  def admin_user
      redirect_to recipes_path unless current_user.admin?
  end
    
end
