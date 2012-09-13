class ChangeFinishDateToEndDate < ActiveRecord::Migration
  def change
    rename_column :events, :finish_date, :end_date
  end
end
