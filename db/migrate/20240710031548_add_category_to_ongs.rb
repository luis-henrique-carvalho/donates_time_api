class AddCategoryToOngs < ActiveRecord::Migration[7.1]
  def change
    add_column :ongs, :category, :integer, null: false, default: 0
  end
end
