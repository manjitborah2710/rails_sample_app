module SessionsHelper
  def log_in(user)
    session[:user_id]=user.id
    current_user
  end

  def current_user
    if @current_user.nil?
      @current_user = User.find_by(:id => session[:user_id])
      return @current_user
    else
      @current_user
    end
  end

  def logged_in?
    return !current_user.nil?  ## not @current_user because current_user might not be called yet
  end

end
