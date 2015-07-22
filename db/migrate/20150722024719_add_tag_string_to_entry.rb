class AddTagStringToEntry < ActiveRecord::Migration
  def change
    add_column :entries, :tag_string, :text
  end
end
