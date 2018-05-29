class RecipeSelection::CLI

  	def call
  		welcome
  		RecipeSelection::Scraper.scrape
  		#RecipeSelection::Scraper.scrape_recipe
  	end
  	
  	def welcome
  		puts "Welcome, you!"
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
  
  