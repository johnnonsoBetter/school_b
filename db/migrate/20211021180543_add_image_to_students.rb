class AddImageToStudents < ActiveRecord::Migration[6.0]
  def change
    add_column :students, :image, :string
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
