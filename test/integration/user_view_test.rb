require "test_helper"

class UserViewTest < ActionDispatch::IntegrationTest

  # def setup
  #   @user=users(:michael)
  #   @user2=users(:munmi)
  # end
  #
  # test "should redirect show if not logged in" do
  #   get user_path(@user)
  #   assert_not flash.empty?
  #   assert_redirected_to login_url
  # end
  #
  # test "should redirect show if logged in with other user" do
  #   get login_path
  #   post login_path, params:{ session:{ email:@user.email,password:'password' } }
  #   get user_path(@user2)
  #   assert_not flash.empty?
  #   assert_redirected_to root_url
  # end
  #
  # test "should continue show if logged in with correct user" do
  #   get login_path
  #   post login_path, params:{ session:{ email:@user.email,password:'password' } }
  #   get user_path(@user)
  #   assert flash.empty?
  #   assert_template 'users/show'
  # end

end
