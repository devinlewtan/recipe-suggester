class RecipeSelection::Ingredient
  attr_accessor  :qty, :food

  #@@all = []

  def initialize(qty, food)
   @qty = qty
   @food = food
  end
end
  
