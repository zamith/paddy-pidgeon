class ChangeGroupsPeopleToContactsGroups < ActiveRecord::Migration
  def up
    drop_table :groups_people

    create_table :contacts_groups, id: false do |t|
      t.references :group
      t.references :contact
    end

    add_index :contacts_groups, [:group_id, :contact_id]
    add_index :contacts_groups, [:contact_id, :group_id]
  end

  def down
    drop_table :contacts_groups

    create_table :groups_people, id: false do |t|
      t.references :group
      t.references :person
    end

    add_index :groups_people, [:group_id, :person_id]
    add_index :groups_people, [:person_id, :group_id]
  end
end
