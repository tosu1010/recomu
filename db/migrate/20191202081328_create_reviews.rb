class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.text :content, null: false
      t.references :user, null: false, foreign_key: true
      t.references :album, null: false, foreign_key: true
      t.references :artist, null: false, foreign_key: true
      t.timestamps
    end
  end
end
