class OrganizationsController < ApplicationController
  def index
    @organizations = policy_scope(Organization)
  end

  def show
    @organization = Organization.find(params[:id])
    @missions = @organization.missions
    authorize @organization
  end
end
