require 'test_helper'

class ReviewTest < ActiveSupport::TestCase
  
  def setup
    @chef = Chef.create(chefname: "jonathan wang", email: "johndoe@example.com")
    @recipe = @chef.recipes.build(name: "Chicken soup", summary: "Chicken tandorri and sauce recipe", description: "Add tomato sauce to boiling oil, add a little spice and tandori sauce and add chicken")
    @review = @recipe.reviews.build(body: "I really love chicken soup!")
    @review.chef = chef
  
  end
  
  test "Review should be valid" do
    assert @review.valid?
  end
  
  test "Chef id must be present" do 
    @review.chef_id = nil
    assert_not @review.valid?
  end
 
 test "Recipe id must be present" do
   @review.recipe_id = nil
   assert_not @review.valid?
 end
 
  test "body should be present" do
    @review.body = " "
    assert_not @review.valid?
  end
  
  test "body length should not be too long" do
    @review.body = "a" * 50
    assert_not @review.valid?
  end
  
  test "body length should not be too short" do 
    @review.body = "aaaa"
    assert_not @review.valid?
  end
  
  
end