class PagesController < ApplicationController
  skip_before_action :set_current_user
  
  def home
  end
end
