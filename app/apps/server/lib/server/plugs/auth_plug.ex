defmodule Server.AuthPlug do
  import Plug.Conn

  alias Server.Context

  @behaviour Plug

  def init(opts), do: opts

  def call(conn, _) do
    context = Context.build_context(conn)

    if Application.get_env(:server, :env) == :dev do
      IO.inspect(context: context)
    end

    assign(conn, :context, context)
  end
end
