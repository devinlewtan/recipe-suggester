require_relative './version'
require_relative './recipe'

require 'watir'
require 'selenium-webdriver'
require 'rubygems'
require 'nokogiri'
require 'open-uri'


class RecipeSelection::Scraper
  	@@browser = Watir::Browser.new :chrome
	@@allRecipes = []
	
  	def self.scrape
  		url = 'http://www.geniuskitchen.com/recipe/all/quick-and-easy'
  		#starting page
		@@browser.goto(url)
		#convert to text page
		@doc2 = Nokogiri::HTML(open(url)) 

		#individual blocks for each recipe link
		recipes = @doc2.css('div.fd-inner-tile')
		

		#population of recipeBook
		recipes.each do |link| 
			href = "http://www.geniuskitchen.com" + link.css('a')[0]['href']
			puts "hi"
      		@@browser.goto(href)
      		@l = Nokogiri::HTML(open(href)) 
   		   	#recipe title extraction
    	    @title = @@browser.title
    
    	    #parse through each ingredient section --> grab description
    	    ingredients = @l.css("ul.ingredient-list li")
    	    
    	    @allIngredients = []
    	    
    	    #populate ingredient array
    	    ingredients.each do |i|
    	    	qty = i.css(span.qty).text
    	    	food = i.css(span.food a).text
    	    	temp = RecipeSelection::Ingredient.new(qty, food)
    	    	@allIngredients << temp
    	    end
    	    
    	    @instructions = ''
    	    #grabbing each step of instructions
    	
    	    @l.css("ol.expanded li").each do |x|
    			@instructions = @instructions + x + ' '
    		end
    	    
    	    #adding recipe objects to library
    	    r = RecipeSelection::Recipe.new(@title, href, @allIngredients, @instructions)
    	    @@allRecipes.push(r)
    	    
    	end
      return @@allRecipes
	end	
end



