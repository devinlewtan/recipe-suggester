class UserIngredientsController < ApplicationController
	before_action :logged_in_user, only: [:index, :create, :edit, :update, :destroy]
	#include SessionsHelper

	def index
		#display all ingredients
    	@user_ingredients = @current_user.user_ingredients
			@user_ingredient = @current_user.user_ingredients.build if logged_in?
			#binding.pry
  	end

	def create
		@user_ingredient = @current_user.user_ingredients.build(user_ingredient_params) if logged_in?
   	 	if @user_ingredient.save
      		flash[:success] = "Ingredient added!"
      		redirect_to user_ingredients_url
    	else
      		render 'sessions/index'
    	end

	end

	def new
		@user_ingredient = UserIngredient.new
	end

	def edit
    	@user_ingredient = UserIngredient.find(params[:id])
  	end

 	def update
    	@user_ingredient = UserIngredient.find(params[:id])
    	if @user_ingredient.update_attributes(user_ingredient_params)
    	flash[:success] = "Ingredient updated"
      	redirect_to user_ingredients_url
      	# Handle a successful update
    	else
      		render 'edit'
    	end
  	end

  	def destroy
  		@user_ingredient = UserIngredient.find(params[:id])
  		@user_ingredient.destroy
    	flash[:success] = "Micropost deleted"
    	redirect_to user_ingredients_url
  	end


  	private

    def user_ingredient_params
      params.require(:user_ingredient).permit(:id, :title)
    end

end
