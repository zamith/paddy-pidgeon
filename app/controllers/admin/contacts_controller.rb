class Admin::ContactsController < Admin::ApplicationController
  load_and_authorize_resource :class => 'Contact'
  respond_to :html

  def mass_add
    @groups = Group.find_all_by_user_id current_user.id
  end

  def mass_update
    @numbers = params[:numbers].split /\D+/

    at_least_one_created = false
    @numbers.each do |number|
      @contact = Contact.new phone_number: number
      @contact.user = current_user
      @contact.group_ids = [params[:group_id]]
      at_least_one_created = true if @contact.save
    end

    if at_least_one_created
      flash[:notice] = t('flash.mass_contacts_created') 
    else
      flash[:error] = t('flash.mass_update_error')
    end
    redirect_to admin_contacts_path
  end

  def index
    @contact = Contact.all
  end

  def show
    @contact = Contact.find(params[:id])
  end

  def new
    @contact = Contact.new
    @groups = Group.find_all_by_user_id current_user.id
  end

  def create
    @contact = Contact.new params[:contact]
    @contact.user = current_user
    @contact.group_ids = [1]

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
    @groups = Group.find_all_by_user_id current_user.id
  end

  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy

    redirect_to admin_contacts_path
  end
end