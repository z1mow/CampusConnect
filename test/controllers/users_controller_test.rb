require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "should get create" do
    assert_difference('User.count') do
      post users_url, params: { user: {
        name: "New Test User",
        username: "newtestuser",
        email: "newtest@acibadem.edu.tr",
        password: "password123",
        password_confirmation: "password123"
      }}
      if response.status == 422
        user = User.new(name: "New Test User", username: "newtestuser", email: "newtest@acibadem.edu.tr", password: "password123", password_confirmation: "password123")
        user.valid?
        puts "Validation errors: #{user.errors.full_messages}"
      end
    end
    assert_redirected_to root_url
  end
end
