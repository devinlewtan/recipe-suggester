require_relative './version'
require_relative './recipe'
require_relative './testing_scraper'

class RecipeSelection::CLI

  	def call
  		display_all
  	end
  	
  	def display_all
  		all = RecipeSelection::Testing_scraper.scrape
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
  
  