class CreateBoxFiles < ActiveRecord::Migration[8.0]
  def change
    create_table :box_files do |t|
      t.references :box, null: false, foreign_key: true
      t.string :filename
      t.string :content_type
      t.binary :data

      t.timestamps
    end
  end
end
