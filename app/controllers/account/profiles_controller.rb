class Account::ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_user

  def show
  end

  def edit
  end

  def update
    @user.update(user_params)
    redirect_to account_profile_path(@profile), :notice => "Votre profil a été modifié!"
  end

  private

  def authorize_user
    authorize @user
  end

  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :phone_number,
      :description,
      :skills,
      :experiences
    )
  end
end
