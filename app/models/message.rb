class Message < ActiveRecord::Base
  belongs_to :event
  belongs_to :group
  belongs_to :user, class_name: "Citygate::User"
  attr_accessible :deliver_date, :text, :group_id

  validates :user_id, presence: true

  before_save :strip_of_unicode_chars

  @@url = URI.parse("http://#{configatrix.message_sender['url']}:#{configatrix.message_sender['port']}")

  def send_from_phone
    phone_numbers = self.group.contacts.select(:phone_number).map(&:phone_number)
    params = {
      'user' => configatrix.message_sender['username'],
      'key' => configatrix.message_sender['password'],
      'message' => self.text,
      'numbers[]' => phone_numbers
    }
    MessageCounter.count(phone_numbers, self.user)
    http = Net::HTTP.new(@@url.host, @@url.port)
    request = Net::HTTP::Post.new("/form")
    request.set_form_data(params)
    response = http.request(request)

    response.code == '200'
  end

  def strip_of_unicode_chars
    self.text = self.text.mb_chars.normalize(:kd).gsub(/[^\x00-\x7F]/,'').to_s
  end

  class << self
    def divide_text(original_message, limit=160)
      original_message.strip_of_unicode_chars.split(/(.{#{limit}})/).collect do |splitted_text|
        Message.new text: splitted_text, group_id: original_message.group_id unless splitted_text.blank?
      end.compact
    end

    def number_of_messages(text)
      text.size/160 + 1
    end

    def available(operator)
      raise ArgumentError, "Invalid operator (vodafone, tmn or optimus)" unless ["vodafone", "tmn", "optimus"].include? operator

      http = Net::HTTP.new(@@url.host, @@url.port)
      request = Net::HTTP::Get.new("/credits/#{operator}")
      response = http.request(request)

      response.body
    end
  end
end
