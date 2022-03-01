require "application_system_test_case"

class AdminDashboardsSystemTest < ApplicationSystemTestCase
  test "admins can access the admin dashboard" do
    admin = create(:member, password: "password", password_confirmation: "password", admin: true)

    visit movies_path

    click_link "Log In"
    fill_in :email, with: admin.email
    fill_in :password, with: "password"
    click_button "Submit"

    assert_text admin.email

    visit admin_dashboards_path

    assert_text "Welcome to the admin portal, #{admin.email}!"
  end

  test "non-admins cannot access the admin dashboard" do
    member = create(:member, password: "password", password_confirmation: "password", admin: false)

    visit movies_path

    click_link "Log In"
    fill_in :email, with: member.email
    fill_in :password, with: "password"
    click_button "Submit"

    assert_text member.email

    visit admin_dashboards_path

    refute_text "Welcome to the admin portal, #{member.email}!"
  end
end
