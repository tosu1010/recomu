class CreateReviewsTags < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews_tags do |t|
      t.references :album, index: true, foreign_key: true
      t.references :tag, index: true, foreign_key: true
      t.timestamps
    end
  end
end
