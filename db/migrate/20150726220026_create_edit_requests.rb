class CreateEditRequests < ActiveRecord::Migration
  def change
    create_table :edit_requests do |t|
      t.references :user, index: true, foreign_key: true
      t.references :entry, index: true, foreign_key: true
      t.text :title
      t.text :body
      t.text :old_body

      t.timestamps null: false
    end
  end
end
