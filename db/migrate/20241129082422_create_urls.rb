class CreateUrls < ActiveRecord::Migration[8.0]
  def change
    create_table :urls do |t|
      t.string :original
      t.string :shortened

      t.timestamps
    end
  end
end
