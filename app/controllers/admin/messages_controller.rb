class Admin::MessagesController < Admin::ApplicationController
  load_and_authorize_resource :class => 'Message'
  respond_to :html

  def new
    @message = Message.new
  end

  def create
    @messages = Message.divide_text params[:message]

    delivered = true
    @messages.each do |message|
      message.user = current_user
      message.save
      #delivered = false unless message.send_from_phone
    end

    if delivered
      flash[:notice] = (@messages.size == 1) ? 
        t("flash.one_message_sent") : 
        t("flash.multiple_messages_sent", number_of_messages: @messages.size) 
    end

    respond_with(@messages, location: admin_messages_path)

  end
end
