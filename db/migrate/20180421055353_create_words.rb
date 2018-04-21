class CreateWords < ActiveRecord::Migration[5.1]
  def change
    create_table :words do |t|
      t.string :title
      t.text :body
      t.user :user

      t.timestamps
    end
  end
end
