class OrganizationsController < ApplicationController
  skip_before_action :set_current_user

  def index
    @organizations = Organization.all
  end

  def show
    @organization = Organization.find(params[:id])
    @missions = @organization.missions
  end
end
