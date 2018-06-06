require_relative './version'
require_relative './recipe'
require_relative './ingredient'

require 'watir'
require 'selenium-webdriver'
require 'rubygems'
require 'nokogiri'
require 'open-uri'


class RecipeSelection::Scraper_new
  	@@browser = Watir::Browser.new :chrome
	@@allRecipes = []
	
  	def self.scrape
  		url = 'http://www.geniuskitchen.com/recipe/all/quick-and-easy'
  		#starting page
		@@browser.goto(url)
		#convert to text page
		@doc = Nokogiri::HTML(open(url)) 
		puts @doc
	
		#individual blocks for each recipe link
		recipes = @doc.css('div.fd-tile fd-recipe')
		puts recipes.text
		puts 'hi'
		#population of recipeBook
		recipes.each do |link| 
			@href = link.css('data-url')
			puts @href
      		@@browser.goto(@href)
      		@l = Nokogiri::HTML(open(@href)) 
      		
   		   	#recipe title extraction
    	    @title = @@browser.title
    
    	    #parse through each ingredient section --> grab description
    	    ingredients = @l.css("ul.ingredient-list")
    	    puts ingredients
    	    @allIngredients = []
    	    
    	    #populate ingredient array
    	    ingredients.each do |i|
    	    	temp = i.css('p')[1].text
    	    	@allIngredients << temp
    	    end
    	    
    	    @instructions = ''
    	    #grabbing each step of instructions
    	
    	    @l.css("div.fela-udbcg p").map do |x|
    			@instructions = @instructions + x + ' '
    		end
    	    
    	    #adding recipe objects to library
    	    r = RecipeSelection::Recipe.new(@title, @href, @allIngredients, @instructions)
    	    @@allRecipes.push(r)
    	    
    	end
      return @@allRecipes
	end	
end