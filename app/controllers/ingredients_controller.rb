class IngredientsController < ApplicationController

	def new
		@ingredient = Ingredient.new
	end

	def index
		@ingredients = Ingredient.all
	end

	def create
		@ingredient = Ingredient.new(ingredient_params)
		puts "Got to here"
 		if @ingredient.save
			puts "Save is good"
  		redirect_to @ingredient
		else
			puts "failyer"
		end
	end

	def show
    	@ingredient = Ingredient.find(params[:id])
  	end

	private

	def ingredient_params
    	params.require(:ingredient).permit(:recipe_id, :title)
	end

end
