require_relative './version'

require 'watir'
require 'selenium-webdriver'


class RecipeSelection::Scraper
  	@@browser = Watir::Browser.new :chrome, headless: true
	@@all = []
	
  	def self.scrape
  		url = 'https://www.hellofresh.com/recipes/quick-meals-collection'
  		#starting page
		@@browser.goto(url)
		#convert to text page
		@doc = Nokogiri::HTML(open(url)) 
		@scraping_block = @doc.css("div.fela-9sirm5 div.fela-16y1plf")
		
		titles = []
		@scraping_block['h3'].each do |title|
			titles << title
			end
	end
	
	def self.scrape_recipe
    	@scraping_block.each do |link|
      		@@browser.goto(link.css('a.href'))
   		   	#recipe title extraction
    	    @title = @@browser.title
    	    #parse through each ingredient section --> grab description
    	    @ingredients[] = link.css("div.fela-2fub81 fela-10v7juv div.fela-bj2f19 fela-xkmok4").text.strip
    	    #grabbing each step of instructions
    	    @instructions = link.css("div.fela-12sjl9r div.fela-1ov7juv p").text.strip
    	    #instantiating new recipe object
    	    @recipe = RecipeSelection::Recipe.new(title, ingredients, instructions)
    	    #adding to library
    	    @@all << recipe
    	end
	  return @@all
	end
end
