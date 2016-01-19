class StylesController < ApplicationController
  before_action :require_user, except: [:show]  

  def new
    @style = Style.new
  end
  
  def show 
    @style = Style.find(params[:id])
    @recipes = @style.recipes.paginate(page: params[:page], per_page: 4) # variable to pass into will_paginate in styles.show page
  end
  
  def create
    @style = Style.new(style_params)
    if @style.save
      flash[:success] = "Your style was created successfully"
      redirect_to recipes_path
    else
      render 'new'
    end
  end
  
  private
  
  def style_params
    params.require(:style).permit(:name)
  end
  
end