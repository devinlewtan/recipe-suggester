module RecipeHelper
  require 'nokogiri'
  require 'open-uri'
  require 'rufus-scheduler'
  require 'rake'
  require 'rubygems'
  require 'watir'
  require 'selenium-webdriver'
  require 'watir-webdriver'


def prepared_for(current_user)
  recipes = Recipe.all
  results = Array.new

  #create hash for user ingredients
  user_ingredients_hash = Hash.new
  current_user.user_ingredients.each do |ing|
    user_ingredients_hash[ing.title.downcase] = true
  end

  #go through each recipe
    recipes.each do |recipe|
       matched_ingredients = []
        #go through user ingredients
        recipe.ingredients.each do |rec_ing|
          if user_ingredients_hash.key?(rec_ing.title.downcase)
            matched_ingredients.push(rec_ing.title)
          end
        end
      #calculate percentage of ingredients prepared
        if recipe.ingredients.length == 0
          next
        else
          percentage = (matched_ingredients.length.to_f / recipe.ingredients.length.to_f * 100).to_int
          #store data in hash for each recipe
          recipe_hash = {:recipe => recipe, :percentage => percentage, :ingredients => matched_ingredients}
          results << recipe_hash
        end

    #add hash to array

      #matched_ingredients = []
  end

  #return first 10 w/ highest matched percentage
  display = results.sort_by{|r| r[:percentage]}.reverse.slice(0,10)
  puts results.to_json
  return display
end

def scrape
  browser = Watir::Browser.new :chrome
  #, headless: true
  url = "https://www.hellofresh.com/recipes/quick-meals-collection"
  #convert to text page
  doc = Nokogiri::HTML(open(url))
  #starting page on Chrome
  browser.goto(url)
  button = browser.button(:class => ["fela-nl96pu", "fela-1vgx6i0"])
  #popup = browser.div(class: 'ui-widget-overlay').wait_while_present
  #:class => "dy-lb-close"
  close = browser.div(:class => "dy-modal-container dy-act-overlay")
  6.times do
    if close.exists?
        puts "hi"
        close.flash
        close.click
        close.wait_while_present
      button.click
    else
      button.click
    end
  end
  allRecipes = Array.new
  #recipe title extraction
  title = browser.title.chomp "Recipe | HelloFresh"
  #individual blocks for each recipe link
  recipes = doc.css('.fela-s2w9uf')

	#population of recipeBook
	recipes.each do |link|
	  href = "https://www.hellofresh.com" + link.css('a')[0]['href']
    browser.goto(href)
    l = Nokogiri::HTML(open(href))
   	#recipe title extraction
    title = browser.title.chomp "Recipe | HelloFresh"
    instructions = ''
    #grabbing each step of instructions
    l.css("div.fela-1qsq4x8 p").map do |x|
      instructions = instructions + x + ' '
    end

    #creating new recipe objects
    if Recipe.find_by(link: "#{href}").nil?
        Recipe.create(title: "#{title}", link: "#{href}", instructions: "#{instructions}")
    end
        #else
        #parse through each ingredient section --> grab description
  	ingredients = l.css("div.fela-1nnptk7")
    #populate ingredient array
	  ingredients.each do |i|
	     title = i.css('p')[1].text
       Ingredient.create(recipe_id: "#{Recipe.find_by(link: "#{href}").id}", title: "#{title}")
    end
  end
 end
end
