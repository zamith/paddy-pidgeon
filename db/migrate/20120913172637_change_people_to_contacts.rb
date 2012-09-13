class ChangePeopleToContacts < ActiveRecord::Migration
  def change
    rename_table :people, :contacts
  end
end
