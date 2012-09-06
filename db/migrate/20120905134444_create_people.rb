class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :name
      t.string :email
      t.string :phone_no, nil: false
      t.references :user, nil: false

      t.timestamps
    end
    add_index :people, :user_id
  end
end
