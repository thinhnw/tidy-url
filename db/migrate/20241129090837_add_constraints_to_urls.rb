class AddConstraintsToUrls < ActiveRecord::Migration[8.0]
  def change
    change_column_null :urls, :original, false
    change_column_null :urls, :shortened, false
    add_index :urls, :shortened, unique: true
  end
end
