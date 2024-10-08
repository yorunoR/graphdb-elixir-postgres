defmodule Server.Router do
  use Server, :router

  use Kaffy.Routes,
    scope: "/admin",
    pipe_through: [:fetch_current_admin_user, :require_authenticated_admin_user]

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
    plug CORSPlug,
      headers: [
        "X-Mildeaw-Project-Key",
        "X-Mildeaw-Api-Key",
        "cid" | CORSPlug.defaults()[:headers]
      ]

    plug :accepts, ["json"]
    plug Server.AuthPlug
  end

  pipeline :graphql_api do
    plug CORSPlug,
      headers: [
        "X-Mildeaw-Project-Key",
        "X-Mildeaw-Api-Key",
        "cid" | CORSPlug.defaults()[:headers]
      ]

    plug :accepts, ["json"]
    plug Server.AbsintheAuthPlug
  end

  scope "/", Server do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/", Server do
    pipe_through :api

    post "/upload/nodes/:node_type_id", UploadController, :nodes
    options "/upload/nodes/:node_type_id", UploadController, :options
    post "/upload/edges/:edge_type_id", UploadController, :edges
    options "/upload/edges/:edge_type_id", UploadController, :options
  end

  # Other scopes may use custom stacks.
  # scope "/api", Server do
  #   pipe_through :api
  # end
  scope "/" do
    pipe_through :graphql_api

    forward "/api", Absinthe.Plug, schema: Graphql.Schema

    forward "/graphiql", Absinthe.Plug.GraphiQL,
      schema: Graphql.Schema,
      interface: :simple,
      socket: ServerWeb.UserSocket
  end

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

    # get "/admin_users/register", AdminUserRegistrationController, :new
    # post "/admin_users/register", AdminUserRegistrationController, :create
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
