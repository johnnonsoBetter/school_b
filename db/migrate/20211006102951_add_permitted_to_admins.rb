class AddPermittedToAdmins < ActiveRecord::Migration[6.0]
  def change
    add_column :admins, :permitted, :boolean, default: false
  
  end
end
