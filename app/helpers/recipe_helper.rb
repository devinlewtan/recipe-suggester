module RecipeHelper
  require 'nokogiri'
  require 'open-uri'
  require 'rufus-scheduler'
  require 'rake'
  require 'rubygems'
  require 'watir'
  require 'selenium-webdriver'
  #require 'watir-webdriver'


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
  #starting page on Chrome
  browser.goto(url)
  #load more pages
  span_pages(browser)
  #convert to text page
  doc = Nokogiri::HTML.parse(browser.html)
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
    r = Recipe.find_by(link: "#{href}")
    if r.nil?
        recipe = Recipe.create(title: "#{title}", link: "#{href}", instructions: "#{instructions}")

        ingredients = l.css("div.fela-1nnptk7")
        #populate ingredient array
    	  ingredients.each do |i|
    	     t = i.css('p')[1].text
           #recipe.ingredients.create!
           result = Ingredient.create!(recipe_id: "#{recipe.id}", title: "#{t}")
           puts "The result of insert was #{result.to_json}"
        end
    end
  end
end

def span_pages(browser)
  sleep(5)
  #browser elements
  load_more = browser.button(:class => ["fela-nl96pu", "fela-1vgx6i0"])
  close_modal = browser.div(:class => "dy-lb-close")

  sleep(5)
  while !(close_modal.exists?) || !(load_more.exists?)
    puts 'not yet loaded:'
    puts('close modal exists:', close_modal.exists?)
  sleep(2)
  end

  close_modal.click
  sleep(5)
  #span multiple pages
  6.times do
  sleep(2)
  load_more.wait_until_present.click
  sleep(2)
  end
end
end
