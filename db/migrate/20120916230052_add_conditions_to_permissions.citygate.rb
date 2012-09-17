# This migration comes from citygate (originally 20120916221334)
class AddConditionsToPermissions < ActiveRecord::Migration
  def change
    add_column :citygate_permissions, :conditions, :string
  end
end
