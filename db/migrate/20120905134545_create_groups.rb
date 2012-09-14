class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.integer :people_count
      t.references :user, nil: false

      t.timestamps
    end
    add_index :groups, :user_id
  end
end
