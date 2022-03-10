defmodule AuthapiWeb.UserController do
  use AuthapiWeb, :controller

  alias Authapi.Accounts
 

  action_fallback AuthapiWeb.FallbackController

  def register(conn, %{"user" => user_params}) do
     with {:ok, user} <- Accounts.create_user(user_params) do
       conn
       |> put_status(:created)
       |> text("User successfully registered with email: "<>" "<> user.email)
     end
  end

end
