class AddQuantityToItem < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :quantity, :integer, default: 0
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
