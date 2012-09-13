class Admin::MessageController < Admin::ApplicationController
  load_and_authorize_resource :class => "Message"
  respond_to :html

  def create
    messages = Message.divide_text params[:message]

    delivered = true
    message.each do |message|
      message.save
      #delivered = false unless message.send_from_phone
    end

    flash[:notice] = t("flash.messages_sent", number_of_messages: messages.size) if delivered
    respond_with(:admin, messages)
  end
end