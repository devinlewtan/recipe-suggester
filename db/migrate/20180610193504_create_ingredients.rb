class CreateIngredients < ActiveRecord::Migration[5.1]
  def change
    create_table :ingredients do |t|
  	  #t.belongs_to :recipe, foreign_key: true
      t.string :title
      t.integer :recipe_id

      t.timestamps
    end
  end
end
