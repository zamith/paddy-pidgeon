class Contact < ActiveRecord::Base
  attr_accessible :email, :name, :phone_number
  has_and_belongs_to_many :groups
  belongs_to :user, class_name: "Citygate::User"

  validates :phone_number, presence: true, format: { with: /(\+351|00351)?\d{9}/, message: I18n.t('admin.contacts.validation.phone_number') }
  validates :user_id, presence: true
end
