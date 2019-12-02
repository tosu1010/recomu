class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.integer :flag, null: false
      t.references :user, null: false, foreign_key: true
      t.references :review, null: false, foreign_key: true
      t.timestamps
    end
  end
end
