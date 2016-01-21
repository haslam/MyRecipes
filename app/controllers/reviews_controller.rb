class ReviewsController < ApplicationController
  before_action :require_review_user
  before_action :recipe_item
  before_action :admin_user, only: :destroy
  
  def create
    @review = @recipe.reviews.build(reviews_params)
    @review.chef = current_user
    
    if @review.save
      flash[:success] = "Review recieved successfully"
      redirect_to :back
    else
      flash[:danger] = "Sorry! your review was not recieved successfully"
      redirect_to :back
    end
    
  end
  
  def destroy
    Review.find(params[:id]).destroy
    flash[:success] = "Review item deleted"
    redirect_to :back
  end
  
  private
     
      def reviews_params
        params.require(:review).permit(:body)
      end
      
      def recipe_item
        @recipe = Recipe.find(params[:recipe_id])
      end
      
      def require_review_user
        if !logged_in?
          flash[:danger] = "You must be logged in to post a review"
          redirect_to :back
        end
      end
      
     
end