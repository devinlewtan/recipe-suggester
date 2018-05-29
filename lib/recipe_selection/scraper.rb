require_relative './version'

require 'watir'
require 'selenium-webdriver'

options = Selenium::WebDriver::Chrome::Options.new
options.add_argument('--headless')
driver = Selenium::WebDriver.for :chrome, options: options

class RecipeSelection::Scraper
  	
  	@@browser = Watir::Browser.new :chrome, headless: true
	
  	def self.scrape
		@@browser.goto('https://www.hellofresh.com/recipes/quick-meals-collection')
		@doc = Nokogiri::HTML(open("browser.html")) 
		@scraping_block = @doc.css("div.fela-9sirm5 div.fela-16y1plf")
	end
	
	def self.scrape_recipe
      @scraping_block('a').each do |link|
      	@@browser.goto(link['href'])
        title = browser.title
        ingredients = link.css("div.fela-2fub81 fela-10v7juv div.fela-bj2f19 fela-xkmok4 p.felac30jy9").text.strip
        instructions = link.css("div.fela-12sjl9r div-fela-1ov7juv").text.strip
        recipe = RecipeSelection::Recipe.new(title, ingredients, instructions)
        RecipeSelection::Recipe.all << recipe
    	end
  	end
  	
  	#def self.display_recipe
    #@@all.each.with_index(1) do |recipe, i|
     # puts "   #{i}.   #{recipe.title}"
    #end
 # end
  
  #	def self.display_ingredients(input)
   # index = input.to_i - 1
    #puts "#{@@all[index].ingredients}"
  #end

  
  end