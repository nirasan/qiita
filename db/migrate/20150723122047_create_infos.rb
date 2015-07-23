class CreateInfos < ActiveRecord::Migration
  def change
    create_table :infos do |t|
      t.references :user, index: true, foreign_key: true
      t.integer :info_type
      t.text :data

      t.timestamps null: false
    end
  end
end
