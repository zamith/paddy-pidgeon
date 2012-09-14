class Admin::ContactsController < Admin::ApplicationController
  load_and_authorize_resource :class => 'Contact'
  respond_to :html

  def index
    @contact = Contact.all
  end

  def show
    @contact = Contact.find(params[:id])
  end

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new params[:contact]
    @contact.user = current_user
    @contact.group_ids = [1]
    p @contact.groups 

    flash[:notice] = t('flash.contact_created', number: @contact.phone_number) if @contact.save
    respond_with(:admin, @contact)
  end

  def update
    @contact = Contact.find(params[:id])

    if @contact.update_attributes(params[:contact])
      flash[:notice] = t('flash.contact_edited', number: @contact.phone_number)
    else
      # fail
    end

    redirect_to admin_contact_path(@contact)
  end

  def edit
    @contact = Contact.find(params[:id])
  end

  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy

    redirect_to admin_contacts_path
  end
end