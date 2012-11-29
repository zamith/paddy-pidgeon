class AddCreditsToUsers < ActiveRecord::Migration
  def change
    add_column :citygate_users, :vodafone, :integer, default: 0
    add_column :citygate_users, :tmn, :integer, default: 0
    add_column :citygate_users, :optimus, :integer, default: 0
  end
end
