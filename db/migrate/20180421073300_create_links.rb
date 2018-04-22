class CreateLinks < ActiveRecord::Migration[5.1]
  def change
    create_table :links do |t|
      t.integer :parent_word_id
      t.integer :child_word_id

      t.timestamps
    end
  end
end
