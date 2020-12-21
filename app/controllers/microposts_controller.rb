class MicropostsController < ApplicationController

  before_action :logged_in_user, only: [:destroy,:create]
  before_action :correct_user, only: [:destroy]

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      s=""
      @micropost.errors.full_messages.each do |msg|
        s+="#{msg}; "
      end
      s=s.strip
      flash[:danger]=s[0..-2]
      redirect_to root_url
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = "Micropost deleted"
    redirect_to request.referrer || root_url ## Note request.referrer
  end

  private

  def micropost_params
    params.require(:micropost).permit(:content,:picture)
  end

  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    redirect_to root_url if @micropost.nil?
  end

end
