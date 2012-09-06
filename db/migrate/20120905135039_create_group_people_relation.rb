class CreateGroupPeopleRelation < ActiveRecord::Migration
  def change
    create_table :groups_people, id: false do |t|
      t.references :group
      t.references :person
    end
    add_index :groups_people, [:group_id, :person_id]
    add_index :groups_people, [:person_id, :group_id]
  end
end
