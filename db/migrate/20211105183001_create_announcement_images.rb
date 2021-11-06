class CreateAnnouncementImages < ActiveRecord::Migration[6.0]
  def change
    create_table :announcement_images do |t|
      t.string :image

      t.timestamps
    end
  end
end
