class Admin::PeopleController < Admin::ApplicationController
  load_and_authorize_resource :class => "Person"
  respond_to :html

  def index
    @people = Person.all
  end

  def show
    @person = Person.find params[:id]
  end

  def new
    @person = Person.new
  end

  def create
    @person = Person.new params[:person]
    @person.user = current_user

    flash[:notice] = t("flash.contact_added", number: @person.phone_no) if @person.save
    respond_with(:admin, @person)
  end
end