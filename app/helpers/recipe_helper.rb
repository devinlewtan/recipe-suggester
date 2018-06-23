module RecipeHelper
  require 'nokogiri'
  require 'open-uri'
  require 'rufus-scheduler'
  require 'rake'
  require 'rubygems'
  require 'watir'
  require 'selenium-webdriver'

def prepared
end

def scrape
  @@browser = Watir::Browser.new :chrome, headless: true

      @url = "https://www.hellofresh.com/recipes/quick-meals-collection"
      #convert to text page
      @doc = Nokogiri::HTML(open(@url))
      #starting page on Chrome
      @@browser.goto(@url)
      @@allRecipes = Array.new
      #recipe title extraction
      @title = @@browser.title.chomp "Recipe | HelloFresh"
      #individual blocks for each recipe link
      recipes = @doc.css('.fela-s2w9uf')

		#population of recipeBook
		recipes.each do |link|
			    @href = "https://www.hellofresh.com" + link.css('a')[0]['href']
      		@@browser.goto(@href)
      		@l = Nokogiri::HTML(open(@href))

   		   	#recipe title extraction
    	    @title = @@browser.title.chomp "Recipe | HelloFresh"

    	    @instructions = ''
    	    #grabbing each step of instructions

    	    @l.css("div.fela-1qsq4x8 p").map do |x|
    			@instructions = @instructions + x + ' '
    		  end

      	  #creating new recipe objects
          if Recipe.find_by(link: "#{@href}").nil?
            Recipe.create(title: "#{@title}", link: "#{@href}", instructions: "#{@instructions}")

          else
            #parse through each ingredient section --> grab description
      	    ingredients = @l.css("div.fela-1nnptk7")

            #populate ingredient array
    	       ingredients.each do |i|
    	       food = i.css('p')[1].text
             qty = i.css('p')[0].text[0]
             Ingredient.create(recipe_id: "#{Recipe.find_by(link: "#{@href}").id}", food: "#{food}", qty: "#{qty}")
           end
        end
    end
 end
end
