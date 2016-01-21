class Review < ActiveRecord::Base
  belongs_to :recipe_params
  belongs_to :chef
  
  validates :body, presence: true
  
end
