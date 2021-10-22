class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.text :body
      t.text :image_data

      t.timestamps
    end
  end
end
