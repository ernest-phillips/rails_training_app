class Admin::DashboardsController < ApplicationController
  def index
    head :forbidden unless current_member&.admin?
  end
end
