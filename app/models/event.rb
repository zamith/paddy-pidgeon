class Event < ActiveRecord::Base
  attr_accessible :end_date, :name, :start_date
  belongs_to :user, class_name: "Citygate::User"

  validates :user_id, presence: true
end
