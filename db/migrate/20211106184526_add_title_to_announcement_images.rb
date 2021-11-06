class AddTitleToAnnouncementImages < ActiveRecord::Migration[6.0]
  def change
    add_column :announcement_images, :title, :string
  end
end
