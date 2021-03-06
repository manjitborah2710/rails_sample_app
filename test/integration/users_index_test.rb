require "test_helper"

class UsersIndexTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = users(:michael)
  end
  test "index including pagination" do
    post login_path, params:{ session: {email:@user.email,password: 'password' } }
    get users_path
    assert_template 'users/index'
    assert_select 'div ul .pagination'
    User.paginate(page: 1,per_page:10).each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.name
    end
  end
end
