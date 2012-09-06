class Message < ActiveRecord::Base
  belongs_to :event
  belongs_to :group
  belongs_to :user, class_name: "Citygate::User"
  attr_accessible :deliver_date, :text

  validates :user_id, presence: true
end
