class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.datetime :start_date
      t.datetime :finish_date
      t.references :user, nil: false

      t.timestamps
    end
    add_index :events, :user_id
  end
end
