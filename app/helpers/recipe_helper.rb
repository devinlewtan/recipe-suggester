#require 'troops_app/recipe_selection/lib/recipe_selection/version'
#require './recipe'

#require 'watir'
#require 'selenium-webdriver'
#require 'rubygems'
#require 'nokogiri'
#require 'open-uri'

module RecipeHelper
require 'watir'
#@@browser = Watir::Browser.new :chrome
	#@@allRecipes = []
	
 # 	def self.scrape
  #		url = 'https://www.hellofresh.com/recipes/quick-meals-collection'
  	#	#starting page
	#	@@browser.goto(url)
	#	#convert to text page
	#	@doc = Nokogiri::HTML(open(url)) 
		
		#individual blocks for each recipe link
	#	recipes = @doc.css('div.fela-vdap0b')
	
		#population of recipeBook
	#	recipes.each do |link| 
	#		href = "https://www.hellofresh.com" + link.css('a')[0]['href']
     # 		@@browser.goto(href)
      #		@l = Nokogiri::HTML(open(href)) 
    #  		
   	#	   	#recipe title extraction
    #	    @title = @@browser.title.chomp "Recipe | HelloFresh"
    #
    #	    #parse through each ingredient section --> grab description
    #	    ingredients = @l.css("div.fela-1nnptk7")
    #	    
    #	    @allIngredients = []
    #	    
    	    #populate ingredient array
    #	    ingredients.each do |i|
    #	    	temp = i.css('p')[1].text
    #	    	#@allIngredients << temp
    #	    	Ingredient.new(temp)
    #	    end
    #	    
    #	    @instructions = ''
    #	    #grabbing each step of instructions
    #	
    #	    @l.css("div.fela-1qsq4x8 p").map do |x|
    #			@instructions = @instructions + x + ' '
    #		end
    	    
    	    #adding recipe objects to library
    	    #r = 
    #	    Recipe.new(@title, href, @allIngredients, @instructions)
    	    #@@allRecipes.push(r)
    	    
    #	end
      #return @@allRecipes
#	end	
end

