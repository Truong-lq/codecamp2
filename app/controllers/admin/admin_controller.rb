class Admin::AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin!

  private

  def authenticate_admin!
    return if current_user.admin?

    redirect_to root_path, alert: "No authorization to access this page"
  end
end