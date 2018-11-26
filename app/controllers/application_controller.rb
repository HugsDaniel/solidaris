class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_current_user

  def default_url_options
    { host: ENV['HOST'] || 'localhost:3000' }
  end

  private

  def set_current_user
    @user = current_user
  end
end
