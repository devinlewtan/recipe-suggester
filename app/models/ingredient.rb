Rails.application.config.active_record.belongs_to_required_by_default = false

class Ingredient < ApplicationRecord
	belongs_to :recipe, optional: true
	#attr_accessor :recipe_id, :title
	#validates_presence_of :title
end
