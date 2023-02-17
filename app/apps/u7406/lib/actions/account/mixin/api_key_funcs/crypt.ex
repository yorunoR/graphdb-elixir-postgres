defmodule Actions.Account.Mixin.ApiKeyFuncs.Crypt do
  @default_ttl :infinity

  def encrypt(plaintext, user_salt) when is_binary(plaintext) do
    Plug.Crypto.encrypt(secret(), user_salt, plaintext)
  end

  def decrypt(ciphertext, user_salt, max_age \\ @default_ttl) when is_binary(ciphertext) do
    Plug.Crypto.decrypt(secret(), user_salt, ciphertext, max_age: max_age)
  end

  defp secret, do: Server.Endpoint.config(:secret_key_base)
end
