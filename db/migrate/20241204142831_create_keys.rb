class CreateKeys < ActiveRecord::Migration[8.0]
  def change
    create_table :keys do |t|
      t.string :name

      t.timestamps
    end
  end
end
