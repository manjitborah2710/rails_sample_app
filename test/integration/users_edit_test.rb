require "test_helper"

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:munmi)
    @user2=users(:michael)
  end

  test "unsuccessful edit" do
    get login_path
    post login_path, params:{ session: { email:@user.email,password:'munmi' }  }
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params:{user: { name:  "Maina",
                                    email: "maina@invalid",
                                    password:              "foo",
                                    password_confirmation: "bar" }}
    assert_template 'users/edit'
  end

  test "successful edit" do
    get edit_user_path(@user)
    get login_path
    post login_path, params:{ session: { email:@user.email,password:'munmi' }  }
    assert_redirected_to edit_user_path(@user)

    name  = "Foo Bar"
    email = "foo@bar.com"
    patch user_path(@user), params:{user: { name:  name,
                                    email: email,
                                    password:              "",
                                    password_confirmation: "" }}
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name,  @user.name
    assert_equal email, @user.email
  end

end
