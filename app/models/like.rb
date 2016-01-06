class Like < ActiveRecord::Base
  
  belongs_to :chef
  belongs_to :recipe
  
  #validate uniqueness on chef for recipe
  validates_uniqueness_of :chef, scope: :recipe  
  
end