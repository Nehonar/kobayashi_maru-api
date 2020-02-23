defmodule KobayashiMaru.Auth.Guardian do
  @moduledoc """
  This file responsibility is to convert between a token
  an a resource (a user) and between a resource (our user)
  and a unique identifier to be encoded in the token
  that will be passed all over the place.
  """
  use Guardian, otp_app: :kobayashi_maru

  @spec subject_for_token(atom | %{id: any}, any) :: {:ok, binary}
  def subject_for_token(resource, _claims) do
    sub = to_string(resource.id)
    {:ok, sub}
  end

  @spec resource_from_claims(nil | keyword | map) :: {:error, String} | {:ok, any}
  def resource_from_claims(claims) do
    case KobayashiMaru.Accounts.get_user(claims["sub"]) do
      nil -> {:error, "User not found"}
      user -> {:ok, user}
    end
  end
end
