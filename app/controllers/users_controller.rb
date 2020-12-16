class UsersController < ApplicationController
  before_action :find_user,only: [:show]

  def new
    @user=User.new
  end

  def create
    param_viewer
    @user=User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      # redirect_to user_url(:id=>@user)
      #         or
      # redirect_to user_url(@user)
      #         or
      # flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render :new
    end
  end

  def index
  end

  def show
  end

  private

    def find_user
      @user=User.find(params[:id])
      param_viewer
    end


    def param_viewer
      print("\n\n"+"*"*15+"\tView Parameters Here\t"+"*"*15,"\n\n",params,"\n\n","*"*55+"\n\n")
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

end
