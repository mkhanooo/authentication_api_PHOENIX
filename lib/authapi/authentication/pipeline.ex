defmodule Authapi.Gaurdian.AuthPipeline do
  @claim %{typ: "access"}

  use Guardian.Plug.Pipeline,
    otp_app: :authapi,
    module: Authapi.Gaurdian,
    error_handle: Authapi.Gaurdian.ErrorHandle


    plug(Guardian.Plug.VerifyHeader, claim: @claim, realm: "Bearer")
    plug(Guardian.Plug.EnsureAuthenticated)
    plug(Guardian.Plug.LoadResource, ensure: true)
 end
