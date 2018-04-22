class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :twitter_id
      t.string :image_url
      t.references :word

      t.timestamps
    end
  end
end
