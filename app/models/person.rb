class Person < ActiveRecord::Base
  attr_accessible :email, :name, :phone_no
  has_and_belongs_to_many :groups
  belongs_to :user, class_name: "Citygate::User"

  validates :phone_no, presence: true
  validates :user_id, presence: true
end
