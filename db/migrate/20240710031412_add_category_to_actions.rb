class AddCategoryToActions < ActiveRecord::Migration[7.1]
  def change
    add_column :actions, :category, :integer, null: false, default: 0
  end
end
