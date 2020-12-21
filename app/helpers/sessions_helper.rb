module SessionsHelper
  def log_in(user)
    session[:user_id]=user.id
    # current_user
  end

  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def current_user
    if @current_user.nil?
      if(user_id=session[:user_id])
        @current_user = User.find_by(:id => user_id)
      elsif (user_id=cookies.signed[:user_id])
        user = User.find_by(id: user_id)
        if user && user.authenticated?(:remember,cookies[:remember_token])
          log_in user
          @current_user = user
        end
      end
    end
    return @current_user
  end

  def logged_in?
    return !current_user.nil?  ## not @current_user because current_user might not be called yet
  end

  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user=nil
  end

  def logged_in_correctly
    if !logged_in?
      store_location
      flash[:danger]="Please log in"
      redirect_to login_path
    elsif !params[:id].to_s.eql?(current_user.id.to_s)
      store_location
      flash[:danger]="You cannot access other user's info"
      redirect_to root_path
    end
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end


  def store_location
    session[:forwarding_url]=request.url if request.get?
  end

  def forward_to_intended(user)
    redirect_to (session[:forwarding_url] || user) ## order in || matters
    session.delete(:forwarding_url)
  end




end
