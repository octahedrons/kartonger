class AddPackedByToBoxes < ActiveRecord::Migration[8.0]
  def change
    add_column :boxes, :packed_by, :string
  end
end
