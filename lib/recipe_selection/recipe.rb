class RecipeSelection::Recipe
  attr_accessor  :title, :link, :ingredients, :instructions

  #@@all = []

  def initialize(title, link, ingredients, instructions)
   @title = title
   @link = link
   @ingredients = ingredients
   @instructions = instructions
  end
end
<<<<<<< HEAD
=======
  
  #def self.display_recipe
   # @@all.each.with_index(1) do |recipe, i|
    #  puts "   #{i}.   #{recipe.title}"
    #end
  #end
  
  #def self.display_ingredients(input)
   #index = input.to_i - 1
   # puts "#{@@all[index].ingredients}"
 # end
>>>>>>> f241105bb07d779c9ec92ec94cb15a8566a5d4b1
  