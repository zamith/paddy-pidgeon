class ChangePhoneNoToPhoneNumber < ActiveRecord::Migration
  def change
    change_table :contacts do |t|
      t.rename :phone_no, :phone_number
    end
  end
end
