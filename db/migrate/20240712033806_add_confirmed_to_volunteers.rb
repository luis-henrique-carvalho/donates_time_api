class AddConfirmedToVolunteers < ActiveRecord::Migration[7.1]
  def change
    add_column :volunteers, :confirmed, :boolean
  end
end
