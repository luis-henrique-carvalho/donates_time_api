class AddActionsLimitToOngs < ActiveRecord::Migration[7.1]
  def change
    add_column :ongs, :actions_limit, :integer, default: 6, null: false
  end
end
