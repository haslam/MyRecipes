class ChefsController < ApplicationController
  before_action :set_chef, only: [:edit, :update, :show] # initialize @chef in set_chef for :edit, :update, and :show 
  before_action :require_same_user, only: [:edit, :update] #executes require_same_user function before edit and update functions
  
  def index
    @chefs = Chef.paginate(page: params[:page], per_page: 3)
  end
  def new
    @chef = Chef.new
  end
  
  def create
    @chef = Chef.new(chef_params)
    if @chef.save
      flash[:success] = "Your account has been created successfully"
      session[:chef_id] = @chef.id  # sets session's chef_id to make the user logged in on register
      redirect_to recipes_path
    else
      render 'new'
    end 
  end
  
  def edit
   #@chef = Chef.find(params[:id]) - performed by set_chef method - takes care of duplicates
  end
  
  def update
   # @chef = Chef.find(params[:id])  - performed by set_chef method
    if @chef.update(chef_params)
      flash[:success] = "Your profile has been updated successfully"
      redirect_to chef_path(@chef) # redirect to show chef path and pass in the @chef object as parameter
    else
      render 'edit'
    end
  end
  
  def show
    #@chef = Chef.find(params[:id]) -  handled by set_chef function
    @recipes = @chef.recipes.paginate(page: params[:page], per_page: 3)
  end
  
  private
    def chef_params
      params.require(:chef).permit(:chefname, :email, :password)
    end
    
    def set_chef
      @chef = Chef.find(params[:id])
    end
    
    def require_same_user
      if current_user != @chef
        flash[:danger] = "You can only edit your own profile"
        redirect_to root_path 
      end
    end
  
end