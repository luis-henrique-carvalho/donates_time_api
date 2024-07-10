class CreateActions < ActiveRecord::Migration[7.1]
  def change
    create_table :actions, id: :uuid do |t|
      t.string :title, null: false
      t.datetime :start_date, null: false
      t.datetime :end_date, null: false
      t.text :description
      t.integer :max_volunteers, null: false
      t.references :ong, type: :uuid, null: false, foreign_key: true

      t.timestamps
    end
  end
end
