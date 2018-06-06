require_relative './version'
require_relative './recipe'
require_relative './scraper'

class RecipeSelection::CLI

  	def call
  		display_all
<<<<<<< HEAD
  		#RecipeSelection::Scraper.scrape
=======
>>>>>>> f241105bb07d779c9ec92ec94cb15a8566a5d4b1
  	end
  	
  	def display_all
  		all = RecipeSelection::Scraper.scrape
    	all.each do |recipe|
    		puts "#{recipe.title}"
    		puts "--------------------------"
    		recipe.ingredients.each do |ingredient|
    			puts "#{ingredient}"
    		end
    		puts "--------------------------"
    		puts "#{recipe.instructions}"
    	end
    end
end
  
  