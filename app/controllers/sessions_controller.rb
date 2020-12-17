class SessionsController < ApplicationController
  def new
  end

  def create
    user_email=params[:session][:email].downcase
    user_pwd=params[:session][:password]
    user=User.find_by(:email => user_email)
    if user && user.authenticate(user_pwd)
      log_in user
      redirect_to user
    else
      flash.now[:danger]="Invalid email/password combination"
      render :new
    end

  end

  def destroy
  end

end
