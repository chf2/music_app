class AddBodyToNote < ActiveRecord::Migration
  def change
    add_column :notes, :body, :text
    change_column :notes, :body, :text, null: false
  end
end
