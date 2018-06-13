class RecipeSelection::Recipe
  attr_accessor  :title, :link, :ingredients, :instructions


  def initialize(title, link, ingredients, instructions)
   @title = title
   @link = link
   @ingredients = ingredients
   @instructions = instructions
  end
end
