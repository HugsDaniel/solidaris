class Admin::OrganizationsController < AdminController
  before_action :authenticate_user!
  before_action :set_organization, only: [:edit, :update, :show]

  def index
    @organizations = policy_scope(Organization)
  end

  def new
    @organization = Organization.new
    authorize @organization
  end

  def create
    @organization = Organization.new(organization_params)
    @organization.manager = @user
    authorize @organization

    if @organization.save
      flash[:notice] = "Successfully created..."
      redirect_to organization_path(@organization)
    else
      flash[:alert] = 'Something went wrong...'
      render :new
    end
  end

  def edit
  end

  def update
    @organization.update(organization_params)

    if @organization.save
      flash[:notice] = "Successfully updated..."
      redirect_to organization_path(@organization)
    else
      flash[:alert] = 'Something went wrong...'
      render :edit
    end
  end

  def show
  end

  private

  def set_organization
    @organization = Organization.find(params[:id])
    authorize @organization
  end

  def organization_params
    params.require(:organization).permit(
      :name,
      :email,
      :phone_number,
      :description,
      :kind,
      :total_volunteers,
      :siren,
      :category,
      :website,
      :facebook,
      :linkedin,
      :twitter,
      :address,
      :creation_date
    )
  end
end
