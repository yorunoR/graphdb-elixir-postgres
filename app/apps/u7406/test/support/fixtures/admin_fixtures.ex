defmodule U7406.AdminFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `U7406.Admin` context.
  """

  def unique_admin_user_email, do: "admin_user#{System.unique_integer()}@example.com"
  def valid_admin_user_password, do: "hello world!"

  def valid_admin_user_attributes(attrs \\ %{}) do
    Enum.into(attrs, %{
      email: unique_admin_user_email(),
      password: valid_admin_user_password()
    })
  end

  def admin_user_fixture(attrs \\ %{}) do
    {:ok, admin_user} =
      attrs
      |> valid_admin_user_attributes()
      |> U7406.Admin.register_admin_user()

    admin_user
  end

  def extract_admin_user_token(fun) do
    {:ok, captured_email} = fun.(&"[TOKEN]#{&1}[TOKEN]")
    [_, token | _] = String.split(captured_email.text_body, "[TOKEN]")
    token
  end
end
