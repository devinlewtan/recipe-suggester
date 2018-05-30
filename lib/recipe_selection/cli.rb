class RecipeSelection::CLI

  	def call
  		#welcome
  		#RecipeSelection::Scraper.scrape
  		display_all
  		#display_recipes
  		#display_ingredients
  	end
  	
  	def welcome
  		puts "Welcome, you!"
  	end
  	
  	def display_all
  		all = RecipeSelection::Scraper.scrape
    	all.each do |recipe|
    		puts "#{recipe.title}"
    		recipe.ingredients.each do |ingredient|
    			puts "#{ingredient}"
    		end
    		puts "--------------------------"
    		puts "#{recipe.instructions}"
    	end
    end
    
  	def display_recipes
  		all = RecipeSelection::Scraper.scrape
    	all.each.with_index(1) do |recipe, i|
    		puts "   #{i}.   #{recipe.title}"
    		puts "--------------------------"
    	end
    end
  
  def display_ingredients
  		all = RecipeSelection::Scraper.scrape
    	all.each do |r|
    		t = r.ingredients.length - 1
    		for i in t do
    			puts r.ingredients[i]
    		end
    	  puts "--------------------------"
    	end
    end

  
  
  
  	def options
  		input = "nil"
  		puts "Please enter input below line"
  		puts"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
  			puts " "
  			input = gets.strip.downcase
  			case input
  			when "show list of pumps"
  			puts "-----------------------------"
  			puts " "
  			list_product
  			puts "-----------------------------"
  			options
  			puts " "
  		when "1"
  		puts "first"
  		puts "-----------------------------"
  			list_series(input)
  			options
  		when "2"
  		puts "second"
  		puts "-----------------------------"
  			list_series(input)
  			options
  		end
  	end
	
	def list_recipe
    RecipeSelection::Scraper.scrape
    RecipeSelection::Scraper.scrape_recipe
    #RecipeSelection::Scraper.display_recipe
  end
  
  #def list_series(input)
   # RecipeSelection::Scraper.scrape
    #RecipeSelection::Scraper.scrape_recipe
    #RecipeSelection::Scraper.display_ingredients(input)
		#  end
  
  end
  
  