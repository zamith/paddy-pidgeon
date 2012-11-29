class Admin::ContactsController < Admin::ApplicationController
  load_and_authorize_resource :class => 'Contact'
  respond_to :html, except: [:available]
  respond_to :json, only:   [:available]

  add_breadcrumb I18n.t('admin.breadcrumbs.home'), :root_path
  add_breadcrumb I18n.t('admin.breadcrumbs.contacts.index'), :admin_contacts_path

  def available
    # Show only the contacts with a name
    if can?(:manage, Citygate::User)
      @contacts = Contact.select([:id, :name]).all.delete_if{|c|c.name.blank?}
    else
      @contacts = Contact.find_all_by_user_id(current_user.id, select: [:id, :name]).delete_if{|c|c.name.blank?}
    end

    if params[:group] != "null"
      @existing_contacts = Contact.select([:id, :name]).where("id in(?)", Group.find(params[:group]).contact_ids).delete_if{|c|c.name.blank?}
    end

    respond_with({available_contacts: @contacts, existing_contacts: @existing_contacts}.to_json)
  end

  def mass_add
    @groups = Group.find_all_by_user_id current_user.id
    add_breadcrumb I18n.t('admin.breadcrumbs.contacts.mass_add'), mass_add_admin_contacts_path
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
      flash[:notice] = t('admin.flash.mass_contacts_created')
    else
      flash[:error] = t('admin.flash.mass_update_error')
    end
    redirect_to admin_contacts_path
  end

  def index
    if can?(:manage, Citygate::User)
      @contacts = Contact.paginate(page: params[:page], per_page: 10)
    else
      @contacts = Contact.paginate(page: params[:page], per_page: 10).find_all_by_user_id current_user.id
    end
  end

  def show
    @contact = Contact.includes(:groups).find(params[:id])

    add_breadcrumb I18n.t('admin.breadcrumbs.contacts.show'), admin_contact_path(@contact)
  end

  def new
    @contact = Contact.new
    @groups = Group.find_all_by_user_id current_user.id

    add_breadcrumb I18n.t('admin.breadcrumbs.contacts.new'), new_admin_contact_path
  end

  def create
    group_ids = params[:contact].delete :group_ids
    @contact = Contact.new params[:contact]
    @contact.user = current_user
    @contact.group_ids = group_ids.split(",")

    if @contact.save
      flash[:notice] = t('admin.flash.contact_created', number: @contact.phone_number)
    else
      flash[:error] = @contact.errors.full_messages.last
    end

    respond_with(@contact, location: admin_contacts_path)
  end

  def update
    @contact = Contact.find(params[:id])
    group_ids = params[:group_ids].split(",") + @contact.group_ids

    if @contact.update_attributes(params[:contact].merge group_ids: group_ids)
      flash[:notice] = t('admin.flash.contact_edited', number: @contact.phone_number)
    else
      flash[:error] = @contact.errors.full_messages.last
    end

    respond_with(@contact, location: admin_contact_path(@contact))
  end

  def edit
    @contact = Contact.find(params[:id])
    @groups = Group.find_all_by_user_id current_user.id

    add_breadcrumb I18n.t('admin.breadcrumbs.contacts.edit'), edit_admin_contact_path(@contact)
  end

  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy

    redirect_to admin_contacts_path
  end
end