class IngredientsController < ApplicationController
	def new
	end
	
	def create
		@ingredient = Ingredient.new(ingredient_params)
 
 		@ingredient.save
  		redirect_to @ingredient
	end
	
	def show
    	@ingredient = Ingredient.find(params[:id])
  	end
  	
	private
	
	def ingredient_params
    	params.require(:ingredient).permit(:qty, :food)
end
