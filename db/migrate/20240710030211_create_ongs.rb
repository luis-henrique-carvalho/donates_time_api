class CreateOngs < ActiveRecord::Migration[7.1]
  def change
    create_table :ongs, id: :uuid do |t|
      t.references :user, type: :uuid, null: false, foreign_key: true
      t.string :name, null: false
      t.string :city, null: false
      t.string :state, null: false
      t.text :description, null: false
      t.string :email, null: false

      t.timestamps
    end
  end
end
