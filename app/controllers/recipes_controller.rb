class RecipesController < ApplicationController
	include RecipeHelper
	
	def index
	@recipes = Recipe.all
	end
	
	def new
	@recipe = Recipe.new
	end
	
	def show
	@recipe = Recipe.find(params[:id])
	end

	
	

	
 	private
	def recipe_params
     	params.require(:recipe).permit(:title, :link, :ingredients, :instructions)
    end
end
