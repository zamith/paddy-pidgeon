class Admin::MessagesController < Admin::ApplicationController
  load_and_authorize_resource :class => 'Message'
  respond_to :html

  def index
    if can?(:manage, Citygate::User)
      @messages = Message.paginate(page: params[:page], per_page: 10)
    else
      @messages = Message.paginate(page: params[:page], per_page: 10).find_all_by_user_id current_user.id
    end
  end

  def show
    @message = Message.find(params[:id])
  end

  def new
    @message = Message.new
    @groups = visible_groups
  end

  def create
    if params[:create_and_send]
      create_and_send
    else
      @message = Message.new(params[:message])
      @message.user = current_user

      if @message.save
        flash[:notice] = t('flash.message_created')
      else
        flash[:error] = @message.errors.full_messages.last
      end

      respond_with(@message, location: admin_messages_path)
    end
  end

  def create_and_send
    @message = Message.new(params[:message])
    @message.user = current_user
    @message.save

    send_message(@message)
  end

  def send_message(message)
    @messages = Message.divide_text message

    delivered = true
    @messages.each do |msg|
      # Sending must occur after saving so that the unicode chars can be stripped
      delivered = false unless msg.send_from_phone
    end

    if delivered
      flash[:notice] = (@messages.size == 1) ?
        t("flash.one_message_sent") :
        t("flash.multiple_messages_sent", number_of_messages: @messages.size)
    else
      flash[:error] = t("flash.error_sending_message")
    end

    respond_with(@messages, location: admin_messages_path)
  end

  def update
    @message = Message.find(params[:id])
    updated = @message.update_attributes(params[:message])
    if params[:edit_and_send] and updated
      send_message(@message)
    else
      if updated
        flash[:notice] = t('flash.message_edited')
      else
        flash[:error] = @message.errors.full_messages.last
      end

      respond_with(@message, location: admin_message_path(@message))
    end
  end

  def edit
    @message = Message.find(params[:id])
    @groups = visible_groups
  end

  def destroy
    @message = Message.find(params[:id])
    @message.destroy

    redirect_to admin_messages_path
  end

  def visible_groups
    if can?(:manage, Citygate::User)
      Group.select([:id, :name]).all
    else
      Group.select([:id, :name]).find_all_by_user_id current_user.id
    end
  end
end
