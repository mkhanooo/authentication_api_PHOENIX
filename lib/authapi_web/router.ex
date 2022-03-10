defmodule AuthapiWeb.Router do
  use AuthapiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
     plug Authapi.Gaurdian.AuthPipeline
  end


  scope "/api", AuthapiWeb do
    pipe_through :api
    post "/users", UserController, :register
    post "/session/new", SessionController, :new
  end

  scope "/api", AuthapiWeb do
    pipe_through [:api, :auth]
    post "/session/refresh", SessionController, :refresh
    post "/session/delete", SessionController, :delete
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
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: AuthapiWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
