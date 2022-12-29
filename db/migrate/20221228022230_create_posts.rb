class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :category , foreign_key: true
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
