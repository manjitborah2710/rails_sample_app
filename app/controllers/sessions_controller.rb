class SessionsController < ApplicationController
  def new
  end

  def create
    user_email=params[:session][:email].downcase
    user_pwd=params[:session][:password]
    user=User.find_by(:email => user_email)
    if user && user.authenticate(user_pwd)
      if user.activated?
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        forward_to_intended(user)
      else
        message  = "Account not activated. "
        message += "Check your email for the activation link."
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash.now[:danger]="Invalid email/password combination"
      render :new
    end

  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

end
