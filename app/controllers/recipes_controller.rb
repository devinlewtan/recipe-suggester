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
	scrape 
	@recipes = Recipe.all
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
    end

	def schedule_scraper
		scheduler = Rufus::Scheduler.new
		scheduler.every "1d" do
			scrape
		end
	end
end
