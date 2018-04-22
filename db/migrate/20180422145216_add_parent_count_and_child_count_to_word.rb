class AddParentCountAndChildCountToWord < ActiveRecord::Migration[5.1]
  def change
    add_column :words, :parent_count, :integer
    add_column :words, :child_count, :integer
  end
end
