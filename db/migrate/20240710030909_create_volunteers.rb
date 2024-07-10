class CreateVolunteers < ActiveRecord::Migration[7.1]
  def change
    create_table :volunteers, id: :uuid do |t|
      t.references :user, type: :uuid, null: false, foreign_key: true
      t.references :action, type: :uuid, null: false, foreign_key: true

      t.timestamps
    end

    add_index :volunteers, %i[user_id action_id], unique: true
  end
end
