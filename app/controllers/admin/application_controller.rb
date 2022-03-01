class Admin::ApplicationController < ApplicationController
  before_action :require_admin

  private

  def require_admin
    head :forbidden unless current_admin?
  end
end
