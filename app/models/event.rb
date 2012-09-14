class Event < ActiveRecord::Base
  attr_accessible :end_date, :name, :start_date
  belongs_to :user, class_name: "Citygate::User"

  validates :user_id, presence: true

  def ongoing?
    (start_date..end_date).cover?(Time.now)
  end
end
