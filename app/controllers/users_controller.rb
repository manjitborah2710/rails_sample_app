class UsersController < ApplicationController
  before_action :find_user,only: [:show,:edit,:update]
  before_action :logged_in_correctly, only: [:edit,:update]
  before_action :admin_user,only: :destroy

  def new
    if logged_in?
      redirect_to root_url
    end
    @user=User.new ## new_record? => true
  end

  def create
    @user=User.new(user_params)
    if @user.save
      # log_in @user
      # flash[:success] = "Welcome to the Sample App!"

      # redirect_to user_url(:id=>@user)
      #         or
      # redirect_to user_url(@user)
      #         or
      # flash[:success] = "Welcome to the Sample App!"
      #         or
      # redirect_to @user
      print("\n\nHere goes the activation link: #{edit_account_activation_url(@user.activation_token,:email=> @user.email)}\n\n")

      UserMailer.account_activation(@user).deliver_now
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render :new
    end
  end

  def index
    if !logged_in?
      store_location
      redirect_to login_url
      return
    end
    @users=User.paginate(page: params[:page],per_page: 10)
  end

  def show
  end


  def edit
    ## new_record? => false

  end

  def update
    if @user.update(user_params)
      # Handle a successful update.
      flash[:success] = "Profile updated"
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  def destroy
    if !logged_in?
      redirect_to login_url
      return
    end
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end


  private

    def find_user
      @user=User.find(params[:id])
    end

    def param_viewer
      print("\n\n"+"*"*15+"\tView Parameters Here\t"+"*"*15,"\n\n",params,"\n\n","*"*55+"\n\n")
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end


end
