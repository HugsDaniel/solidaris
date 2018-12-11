class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_current_user

  include Pundit

  after_action :verify_authorized, except: [:home, :index], unless: :devise_controller?
  after_action :verify_policy_scoped, only: :index, unless: :devise_controller?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def default_url_options
    { host: ENV['HOST'] || 'localhost:3000' }
  end

  private
  
  def set_current_user
    @user = current_user
  end

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(root_path)
  end
end
