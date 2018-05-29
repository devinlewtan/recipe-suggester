class RecipeSelection::Recipe
  attr_accessor  :title, :ingredients, :instructions

  @@all = []

  def initialize(title=nil, ingredients=nil, instructions=nil)
   @title = title
   @ingredients = ingredients[]
   @instructions = instructions
  end

  def self.all
   @@all
  end
end