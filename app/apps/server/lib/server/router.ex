defmodule Server.Router do
  use Server, :router

  import Server.AdminUserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {Server.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_admin_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Server do
    pipe_through :browser

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", Server do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: Server.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  ## Authentication routes

  scope "/", Server do
    pipe_through [:browser, :redirect_if_admin_user_is_authenticated]

    get "/admin_users/register", AdminUserRegistrationController, :new
    post "/admin_users/register", AdminUserRegistrationController, :create
    get "/admin_users/log_in", AdminUserSessionController, :new
    post "/admin_users/log_in", AdminUserSessionController, :create
    get "/admin_users/reset_password", AdminUserResetPasswordController, :new
    post "/admin_users/reset_password", AdminUserResetPasswordController, :create
    get "/admin_users/reset_password/:token", AdminUserResetPasswordController, :edit
    put "/admin_users/reset_password/:token", AdminUserResetPasswordController, :update
  end

  scope "/", Server do
    pipe_through [:browser, :require_authenticated_admin_user]

    get "/admin_users/settings", AdminUserSettingsController, :edit
    put "/admin_users/settings", AdminUserSettingsController, :update
    get "/admin_users/settings/confirm_email/:token", AdminUserSettingsController, :confirm_email
  end

  scope "/", Server do
    pipe_through [:browser]

    delete "/admin_users/log_out", AdminUserSessionController, :delete
    get "/admin_users/confirm", AdminUserConfirmationController, :new
    post "/admin_users/confirm", AdminUserConfirmationController, :create
    get "/admin_users/confirm/:token", AdminUserConfirmationController, :edit
    post "/admin_users/confirm/:token", AdminUserConfirmationController, :update
  end
end
