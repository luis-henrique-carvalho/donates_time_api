class CreateMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :messages, id: :uuid do |t|
      t.text :content
      t.references :channel, null: false, foreign_key: true, type: :uuid
      t.references :volunteer, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
