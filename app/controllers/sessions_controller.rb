class SessionsController < ApplicationController
  def new
  end

  def create
    member = Member.find_by(email: params[:email])
    if member&.authenticate(params[:password])
      session[:member_id] = member.id
      redirect_to movies_path
    else
      flash[:error] = "Unknown user or wrong password"
      render :new
    end
  end
end
