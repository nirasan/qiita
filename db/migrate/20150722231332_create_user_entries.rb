class CreateUserEntries < ActiveRecord::Migration
  def change
    create_table :user_entries do |t|
      t.references :user, index: true, foreign_key: true
      t.references :entry, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
