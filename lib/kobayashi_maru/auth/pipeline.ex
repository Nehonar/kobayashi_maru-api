defmodule KobayashiMaru.Auth.Pipeline do
  @moduledoc """
  Essentially checks that a request made to our app has a header with the token,
  ensure that the token is valid and, if it is, loads the resource automatically
  (that is, loads the user corresponding to the token's claims["sub"] value
  in the encrypted token).
  """
  use Guardian.Plug.Pipeline,
    otp_app: :kobayashi_maru,
    module: KobayashiMaru.Auth.Guardian,
    error_handler: KobayashiMaru.Auth.ErrorHandler

  plug(Guardian.Plug.VerifyHeader)
  plug(Guardian.Plug.EnsureAuthenticated)
  plug(Guardian.Plug.LoadResource)
end
