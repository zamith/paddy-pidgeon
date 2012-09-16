class Group < ActiveRecord::Base
  attr_accessible :name
  has_and_belongs_to_many :contacts
  belongs_to :user, class_name: "Citygate::User"

  validates :user_id, presence: true
end
