class RecipeSelection::Recipe
  attr_accessor  :title, :ingredients, :instructions

  #@@all = []

  def initialize(title, ingredients, instructions)
   @title = title
   @ingredients = ingredients
   @instructions = instructions
  end

  
  #def self.display_recipe
    #@@all.each.with_index(1) do |recipe, i|
     # puts "   #{i}.   #{recipe.title}"
    #end
 # end
  
  #	def self.display_ingredients(input)
   # index = input.to_i - 1
    #puts "#{@@all[index].ingredients}"
  #end
  
end