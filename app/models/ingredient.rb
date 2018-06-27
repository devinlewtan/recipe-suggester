class Ingredient < ApplicationRecord
	belongs_to :recipe
	attr_accessor :recipe_id
end
