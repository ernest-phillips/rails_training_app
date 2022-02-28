class Admin::DashboardsController < ApplicationController
  def index
    head :forbidden unless current_admin?
  end
end
