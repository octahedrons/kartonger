class AddBoxRefToActions < ActiveRecord::Migration[8.0]
  def change
    add_reference :actions, :box, null: false, foreign_key: true
  end
end
