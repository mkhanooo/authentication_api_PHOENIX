defmodule AuthapiWeb.SessionView do
  use AuthapiWeb, :view

  def render("token.json", %{access_token: access_token}) do
    %{access_token: access_token}
  end
end
