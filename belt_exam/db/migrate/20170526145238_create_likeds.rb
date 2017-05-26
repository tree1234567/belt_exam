class CreateLikeds < ActiveRecord::Migration
  def change
    create_table :likeds do |t|
      t.references :user, index: true, foreign_key: true
      t.references :song, index: true, foreign_key: true
      t.integer :likes

      t.timestamps null: false
    end
  end
end
