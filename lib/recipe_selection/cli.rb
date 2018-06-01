class RecipeSelection::CLI

  	def call
  		display_all
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
  
  