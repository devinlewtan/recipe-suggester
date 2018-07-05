module RecipeHelper
  require 'nokogiri'
  require 'open-uri'
  require 'rufus-scheduler'
  require 'rake'
  require 'rubygems'
  require 'watir'
  require 'selenium-webdriver'
include SessionsHelper

def prepared_for?(current_user)
  puts current_user.to_json
  recipes = Recipe.all
  prepared_for = Array.new

  #go through each recipe
    recipes.each do |recipe|
      #this is to check if there are left over ingredients once all deleted
      puts recipe.title
      temp = recipe.ingredients
      #go through user ingredients
      current_user.user_ingredients.each do |user_in|
        #is the ingredient in the recipe?
        if !recipe.ingredients.include?(user_in)
        #if no --> check next ingredient
          next
        #if yes --> remove ingredient from temp ingredient array
        else
          temp.delete(user_in)
        end
      end
    temp.empty?
    prepared_for << recipe
  end
  return prepared_for
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
