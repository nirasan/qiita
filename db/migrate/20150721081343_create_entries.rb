class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.references :user, index: true, foreign_key: true
      t.text :title
      t.text :body

      t.timestamps null: false
    end
  end
end
