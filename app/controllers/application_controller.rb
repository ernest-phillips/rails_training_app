class ApplicationController < ActionController::Base
  helper_method :current_member

  def current_member
    return unless session[:member_id]

    @current_member ||= Member.find(session[:member_id])
  end


  def current_admin?
    current_member&.admin?
  end
end
