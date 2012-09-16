class Admin::MessagesController < Admin::ApplicationController
  load_and_authorize_resource :class => 'Message'
  respond_to :html

  def index
    @contact = Message.all
  end

  def show
    @message = Message.find(params[:id])
  end

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(params[:message])
    @message.user = current_user

    flash[:notice] = t('flash.message_created', text: @message.text) if @message.save

    respond_with(@message, location: admin_messages_path)
  end

  def send_message
    @messages = Message.divide_text params[:message]

    delivered = true
    @messages.each do |message|
      message.user = current_user
      message.save

      # Sending must occur after saving so that the unicode chars can be stripped
      #delivered = false unless message.send_from_phone
    end

    if delivered
      flash[:notice] = (@messages.size == 1) ? 
        t("flash.one_message_sent") : 
        t("flash.multiple_messages_sent", number_of_messages: @messages.size) 
    end

    respond_with(@messages, location: admin_messages_path)
  end

  def update
    @message = Message.find(params[:id])

    if @message.update_attributes(params[:message])
      flash[:notice] = t('flash.message_edited', name: @message.text)
    else
      # fail
    end

    respond_with(@message, location: admin_message_path(@message))
  end

  def edit
    @message = Message.find(params[:id])
  end

  def destroy
    @message = Message.find(params[:id])
    @message.destroy

    redirect_to admin_messages_path
  end
end
