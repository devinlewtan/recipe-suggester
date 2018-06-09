class UserIngredientsController < ApplicationController
	before_action :logged_in_user, only: [:index, :create, :edit, :update, :destroy]
	include SessionsHelper
	def index
		#display all ingredients
    	@user_ingredients = UserIngredient.all
    	@user_ingredient = current_user.user_ingredients.build if logged_in?
  	end
 	
	def create
		@user_ingredient = current_user.user_ingredients.build(user_ingredient_params)
   	 	if @user_ingredient.save
      		flash[:success] = "Ingredient added!"
      		redirect_to user_ingredients_url
    	else
      		render 'static_pages/home'
    	end
    
	end
	
	#def show
    #	@user_ingredient = UserIngredient.find(params[:id])
  	#end
 
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
  	end
  	
  	
  	private

    def user_ingredient_params
      params.require(:user_ingredient).permit(:id, :food, :qty)
    end
    
end



