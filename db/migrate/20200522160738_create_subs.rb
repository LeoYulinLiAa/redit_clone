class CreateSubs < ActiveRecord::Migration[5.2]
  def change
    create_table :subs do |t|
      t.string :title, null: false, index: { unique: true }
      t.text :description, null: false
      t.references :moderator, foreign_key: { to_table: :users }, null: false

      t.timestamps null: false
    end
  end
end
