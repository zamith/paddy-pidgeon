class Message < ActiveRecord::Base
  belongs_to :event
  belongs_to :group
  belongs_to :user, class_name: "Citygate::User"
  attr_accessible :deliver_date, :text

  validates :user_id, presence: true

  def send_from_phone
    params = {
      'user' => configatrix.message_sender['username'], 
      'key' => configatrix.message_sender['password'],
      'message' => self.text,
      'numbers' => self.group.contacts
    }
    url = URI.parse("#{configatrix.message_sender['url']}:#{configatrix.message_sender['port']}")
    resp, data = Net::HTTP.post_form(url, params)
    puts resp.inspect
    puts data.inspect
  end

  class << self
    def divide_text(original_message, limit=160)
      original_message[:text].split(/(.{#{limit}})/).collect do |splitted_text|
        deliver_date = Time.new original_message["deliver_date(1i)"], original_message["deliver_date(2i)"], original_message["deliver_date(3i)"]
        Message.new deliver_date: deliver_date, text: splitted_text unless splitted_text.blank?
      end.compact
    end

    def number_of_messages(text)
      text.size/160 + 1
    end
  end
end
