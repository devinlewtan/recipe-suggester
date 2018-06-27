require 'nokogiri'
require 'open-uri'
require 'rufus-scheduler'
require 'rake'
require 'rubygems'
require 'watir'
require 'selenium-webdriver'
include RecipeHelper
class RecipesController < ApplicationController

	def index
	#schedule_scraper
	schedule_scraper
	#@recipes = Recipe.all
	@recipes = Recipe.all
	@id = Ingredient.find_by(params[:id])
	@ingredients = Ingredient.create(food: @id,
 qty: '10')
	#@recipes.prepared_for?
	#set_cookies
	Recipe.connection
	#@cookies =  Recipe.display_ingreds
  end

	def new
	@recipe = Recipe.new
	end

	def create
	@recipe = Recipe.new(recipe_params)
	end

	def show
	@recipe = Recipe.find(params[:id])
	end





 	private
	def recipe_params
     	params.require(:recipe).permit(:title, :link, :instructions)

			#@recipe_params = {
	    #title: 'test', ingredients_attributes: [
	     # { food: 'Kari, the awesome Ruby documentation browser!' },
	     # { qty: '10' }
	   # ]
	 # }
end
	def schedule_scraper
		scheduler = Rufus::Scheduler.new
		scheduler.every "1d" do
			scrape
		end
	end
end
