class ChangeParentCountAndChildCountToWord < ActiveRecord::Migration[5.1]
  def change
    change_column :words, :parent_count, :integer, null: false, default: 0
    change_column :words, :child_count, :integer, null: false, default: 0
  end
end
