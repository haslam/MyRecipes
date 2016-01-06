class LoginsController < ApplicationController
  
  def new
  
  end
  
  def create
    ## we can use a local variable since we not passing it globally for a CRUD model back actions - local var is without @
    chef = Chef.find_by(email: params[:email])
    
    if chef && chef.authenticate(params[:password])
      session[:chef_id] = chef.id  # store chef id into session's chef_id variable
      flash[:success] = "You are logged in"
      redirect_to recipes_path
    else
      flash.now[:danger] = "Incorrect email/password"
      render 'new'
    end
  
  end
  
  def destroy
    session[:chef_id] = nil # set session's chef_id to nil
    flash[:success] = "You have logged out"
    redirect_to root_path
  end
  
end