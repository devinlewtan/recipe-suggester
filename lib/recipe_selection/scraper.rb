require_relative './version'
require_relative './recipe'

require 'watir'
require 'selenium-webdriver'


class RecipeSelection::Scraper
  	@@browser = Watir::Browser.new :chrome, headless: true
	@@allRecipes = []
	
  	def self.scrape
  		url = 'https://www.hellofresh.com/recipes/quick-meals-collection'
  		#starting page
		@@browser.goto(url)
		#convert to text page
		@doc = Nokogiri::HTML(open(url)) 
		#large chunk of HTML
		@scraping_block = @doc.css("div.fela-9sirm5 div.fela-16y1plf")
		
		#individual blocks for each recipe link
		recipes = @doc.css('div.fela-16y1plf')
		
		#population of recipeBook
		recipes.each do |link| 
			href = "https://www.hellofresh.com" + link.css('a')[0]['href']
      		@@browser.goto(href)
      		
   		   	#recipe title extraction
    	    @title = @@browser.title
    	    #link.css('h3.fela-1amo4zy').text
    	    
    	    #parse through each ingredient section --> grab description
    	    ingredients = link.css("div.fela-bj2f19 fela-xkmok4 div.fela-1nnptk7")
    	    @allIngredients = []
    	    
    	    #populate ingredient array
    	    ingredients.each do |i|
    	    	@allIngredients << i.css(p.fela-c30jy9).text
    	    end
    	    
    	    #grabbing each step of instructions
    	    @instructions = link.css("div.fela-udbcg p").text
    	    puts @instructions
    	    
    	    #adding recipe objects to library
    	    r = RecipeSelection::Recipe.new(@title, @allIngredients, @instructions)
    	    @@allRecipes.push(r)
    	end
      return @@allRecipes
	end	
end
	
    	    #@ingredients = link.css("div.fela-2fub81 fela-10v7juv div.fela-bj2f19 fela-xkmok4").text.strip
    	    
    	    
