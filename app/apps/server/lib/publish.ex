defmodule Publish do
  alias Absinthe.Subscription
  alias Server.Endpoint

  def new_user(user) do
    Subscription.publish(Endpoint, user, new_user: "*")
  end
end
