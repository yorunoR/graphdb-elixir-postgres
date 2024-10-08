defmodule Server.AdminUserResetPasswordControllerTest do
  use Server.ConnCase, async: true

  alias U7406.Admin
  alias U7406.Repo
  import U7406.AdminFixtures

  setup do
    %{admin_user: admin_user_fixture()}
  end

  describe "GET /admin_users/reset_password" do
    test "renders the reset password page", %{conn: conn} do
      conn = get(conn, Routes.admin_user_reset_password_path(conn, :new))
      response = html_response(conn, 200)
      assert response =~ "<h1>Forgot your password?</h1>"
    end
  end

  describe "POST /admin_users/reset_password" do
    @tag :capture_log
    test "sends a new reset password token", %{conn: conn, admin_user: admin_user} do
      conn =
        post(conn, Routes.admin_user_reset_password_path(conn, :create), %{
          "admin_user" => %{"email" => admin_user.email}
        })

      assert redirected_to(conn) == "/"
      assert get_flash(conn, :info) =~ "If your email is in our system"

      assert Repo.get_by!(Admin.AdminUserToken, admin_user_id: admin_user.id).context ==
               "reset_password"
    end

    test "does not send reset password token if email is invalid", %{conn: conn} do
      conn =
        post(conn, Routes.admin_user_reset_password_path(conn, :create), %{
          "admin_user" => %{"email" => "unknown@example.com"}
        })

      assert redirected_to(conn) == "/"
      assert get_flash(conn, :info) =~ "If your email is in our system"
      assert Repo.all(Admin.AdminUserToken) == []
    end
  end

  describe "GET /admin_users/reset_password/:token" do
    setup %{admin_user: admin_user} do
      token =
        extract_admin_user_token(fn url ->
          Admin.deliver_admin_user_reset_password_instructions(admin_user, url)
        end)

      %{token: token}
    end

    test "renders reset password", %{conn: conn, token: token} do
      conn = get(conn, Routes.admin_user_reset_password_path(conn, :edit, token))
      assert html_response(conn, 200) =~ "<h1>Reset password</h1>"
    end

    test "does not render reset password with invalid token", %{conn: conn} do
      conn = get(conn, Routes.admin_user_reset_password_path(conn, :edit, "oops"))
      assert redirected_to(conn) == "/"
      assert get_flash(conn, :error) =~ "Reset password link is invalid or it has expired"
    end
  end

  describe "PUT /admin_users/reset_password/:token" do
    setup %{admin_user: admin_user} do
      token =
        extract_admin_user_token(fn url ->
          Admin.deliver_admin_user_reset_password_instructions(admin_user, url)
        end)

      %{token: token}
    end

    test "resets password once", %{conn: conn, admin_user: admin_user, token: token} do
      conn =
        put(conn, Routes.admin_user_reset_password_path(conn, :update, token), %{
          "admin_user" => %{
            "password" => "new valid password",
            "password_confirmation" => "new valid password"
          }
        })

      assert redirected_to(conn) == Routes.admin_user_session_path(conn, :new)
      refute get_session(conn, :admin_user_token)
      assert get_flash(conn, :info) =~ "Password reset successfully"
      assert Admin.get_admin_user_by_email_and_password(admin_user.email, "new valid password")
    end

    test "does not reset password on invalid data", %{conn: conn, token: token} do
      conn =
        put(conn, Routes.admin_user_reset_password_path(conn, :update, token), %{
          "admin_user" => %{
            "password" => "short",
            "password_confirmation" => "does not match"
          }
        })

      response = html_response(conn, 200)
      assert response =~ "<h1>Reset password</h1>"
      assert response =~ "should be at least 6 character(s)"
      assert response =~ "does not match password"
    end

    test "does not reset password with invalid token", %{conn: conn} do
      conn = put(conn, Routes.admin_user_reset_password_path(conn, :update, "oops"))
      assert redirected_to(conn) == "/"
      assert get_flash(conn, :error) =~ "Reset password link is invalid or it has expired"
    end
  end
end
