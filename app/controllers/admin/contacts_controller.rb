class Admin::ContactsController < Admin::ApplicationController
  load_and_authorize_resource :class => 'Contact'
  respond_to :html, except: [:available]
  respond_to :json, only:   [:available]

  def available
    # Show only the contacts with a name
    @contacts = Contact.find_all_by_user_id(current_user.id, select: [:id, :name]).delete_if{|c|c.name.blank?}

    respond_with @contacts
  end

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
    @contact = Contact.find_all_by_user_id current_user.id
  end

  def show
    @contact = Contact.includes(:groups).find(params[:id])
  end

  def new
    @contact = Contact.new
    @groups = Group.find_all_by_user_id current_user.id
  end

  def create
    @contact = Contact.new params[:contact]
    @contact.user = current_user
    @contact.group_ids = params[:groups].split(",")

    if @contact.save
      flash[:notice] = t('flash.contact_created', number: @contact.phone_number)
    else
      flash[:error] = @contact.errors.full_messages.last
    end

    respond_with(@contact, location: admin_contacts_path)
  end

  def update
    @contact = Contact.find(params[:id])

    if @contact.update_attributes(params[:contact])
      flash[:notice] = t('flash.contact_edited', number: @contact.phone_number)
    else
      flash[:error] = @contact.errors.full_messages.last
    end

    respond_with(@contact, location: admin_contact_path(@contact))
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