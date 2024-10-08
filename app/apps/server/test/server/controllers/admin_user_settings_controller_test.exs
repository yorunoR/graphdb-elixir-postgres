defmodule Server.AdminUserSettingsControllerTest do
  use Server.ConnCase, async: true

  alias U7406.Admin
  import U7406.AdminFixtures

  setup :register_and_log_in_admin_user

  describe "GET /admin_users/settings" do
    test "renders settings page", %{conn: conn} do
      conn = get(conn, Routes.admin_user_settings_path(conn, :edit))
      response = html_response(conn, 200)
      assert response =~ "<h1>Settings</h1>"
    end

    test "redirects if admin_user is not logged in" do
      conn = build_conn()
      conn = get(conn, Routes.admin_user_settings_path(conn, :edit))
      assert redirected_to(conn) == Routes.admin_user_session_path(conn, :new)
    end
  end

  describe "PUT /admin_users/settings (change password form)" do
    test "updates the admin_user password and resets tokens", %{
      conn: conn,
      admin_user: admin_user
    } do
      new_password_conn =
        put(conn, Routes.admin_user_settings_path(conn, :update), %{
          "action" => "update_password",
          "current_password" => valid_admin_user_password(),
          "admin_user" => %{
            "password" => "new valid password",
            "password_confirmation" => "new valid password"
          }
        })

      assert redirected_to(new_password_conn) == Routes.admin_user_settings_path(conn, :edit)

      assert get_session(new_password_conn, :admin_user_token) !=
               get_session(conn, :admin_user_token)

      assert get_flash(new_password_conn, :info) =~ "Password updated successfully"
      assert Admin.get_admin_user_by_email_and_password(admin_user.email, "new valid password")
    end

    test "does not update password on invalid data", %{conn: conn} do
      old_password_conn =
        put(conn, Routes.admin_user_settings_path(conn, :update), %{
          "action" => "update_password",
          "current_password" => "invalid",
          "admin_user" => %{
            "password" => "short",
            "password_confirmation" => "does not match"
          }
        })

      response = html_response(old_password_conn, 200)
      assert response =~ "<h1>Settings</h1>"
      assert response =~ "should be at least 6 character(s)"
      assert response =~ "does not match password"
      assert response =~ "is not valid"

      assert get_session(old_password_conn, :admin_user_token) ==
               get_session(conn, :admin_user_token)
    end
  end

  describe "PUT /admin_users/settings (change email form)" do
    @tag :capture_log
    test "updates the admin_user email", %{conn: conn, admin_user: admin_user} do
      conn =
        put(conn, Routes.admin_user_settings_path(conn, :update), %{
          "action" => "update_email",
          "current_password" => valid_admin_user_password(),
          "admin_user" => %{"email" => unique_admin_user_email()}
        })

      assert redirected_to(conn) == Routes.admin_user_settings_path(conn, :edit)
      assert get_flash(conn, :info) =~ "A link to confirm your email"
      assert Admin.get_admin_user_by_email(admin_user.email)
    end

    test "does not update email on invalid data", %{conn: conn} do
      conn =
        put(conn, Routes.admin_user_settings_path(conn, :update), %{
          "action" => "update_email",
          "current_password" => "invalid",
          "admin_user" => %{"email" => "with spaces"}
        })

      response = html_response(conn, 200)
      assert response =~ "<h1>Settings</h1>"
      assert response =~ "must have the @ sign and no spaces"
      assert response =~ "is not valid"
    end
  end

  describe "GET /admin_users/settings/confirm_email/:token" do
    setup %{admin_user: admin_user} do
      email = unique_admin_user_email()

      token =
        extract_admin_user_token(fn url ->
          Admin.deliver_update_email_instructions(
            %{admin_user | email: email},
            admin_user.email,
            url
          )
        end)

      %{token: token, email: email}
    end

    test "updates the admin_user email once", %{
      conn: conn,
      admin_user: admin_user,
      token: token,
      email: email
    } do
      conn = get(conn, Routes.admin_user_settings_path(conn, :confirm_email, token))
      assert redirected_to(conn) == Routes.admin_user_settings_path(conn, :edit)
      assert get_flash(conn, :info) =~ "Email changed successfully"
      refute Admin.get_admin_user_by_email(admin_user.email)
      assert Admin.get_admin_user_by_email(email)

      conn = get(conn, Routes.admin_user_settings_path(conn, :confirm_email, token))
      assert redirected_to(conn) == Routes.admin_user_settings_path(conn, :edit)
      assert get_flash(conn, :error) =~ "Email change link is invalid or it has expired"
    end

    test "does not update email with invalid token", %{conn: conn, admin_user: admin_user} do
      conn = get(conn, Routes.admin_user_settings_path(conn, :confirm_email, "oops"))
      assert redirected_to(conn) == Routes.admin_user_settings_path(conn, :edit)
      assert get_flash(conn, :error) =~ "Email change link is invalid or it has expired"
      assert Admin.get_admin_user_by_email(admin_user.email)
    end

    test "redirects if admin_user is not logged in", %{token: token} do
      conn = build_conn()
      conn = get(conn, Routes.admin_user_settings_path(conn, :confirm_email, token))
      assert redirected_to(conn) == Routes.admin_user_session_path(conn, :new)
    end
  end
end
