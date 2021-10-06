class AddRoleToAdmins < ActiveRecord::Migration[6.0]
  def change
    add_column :admins, :role, :string, default: "admin"
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
