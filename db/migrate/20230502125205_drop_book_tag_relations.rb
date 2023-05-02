class DropBookTagRelations < ActiveRecord::Migration[6.1]
  def change
     drop_table :book_tag_relations do |t|
      t.references :book, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
