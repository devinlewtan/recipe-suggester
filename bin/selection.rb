require "bundler/setup"
require './lib/recipe_selection'
RecipeSelection::CLI.new.call