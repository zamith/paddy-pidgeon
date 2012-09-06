class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :text
      t.references :event
      t.references :group
      t.references :user, nil: false
      t.datetime :deliver_date

      t.timestamps
    end
    add_index :messages, :event_id
    add_index :messages, :group_id
    add_index :messages, :user_id
  end
end
