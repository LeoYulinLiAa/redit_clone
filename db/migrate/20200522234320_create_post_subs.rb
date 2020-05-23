class CreatePostSubs < ActiveRecord::Migration[5.2]
  def change
    create_table :post_subs do |t|
      t.references :post, foreign_key: true, null: false
      t.references :sub, foreign_key: true, null: false

      t.timestamps
    end
    add_index :post_subs, %i[post_id sub_id]
  end
end
