class UserIngredientController < ApplicationController
	def fridge
    	@user_ingredients = User_ingredient.all
  	end
 
	def show
    	@user_ingredient = User_ingredient.find(params[:id])
  	end
 
	def new
	end
end
