class CreateBoxes < ActiveRecord::Migration[8.0]
  def change
    create_table :boxes do |t|
      t.integer :number
      t.string :room
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
