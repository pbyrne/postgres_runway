defmodule PostgresRunway.Connection do
  @moduledoc """
  Encapsulation of Postgres connection. Start it up with `start_link` and
  perform queries with `execute`.

  iex > PostgresRunway.Connection.start_link
  iex > PostgresRunway.Connection.execute "select now()"
  """

  # Public API
  def start_link do
    Agent.start_link(&postgrex/0, name: __MODULE__)
  end

  def execute(query) do
    Agent.get(__MODULE__, fn connection -> Postgrex.query!(connection, query, []) end)
  end

  defp postgrex do
    {:ok, connection} = Postgrex.start_link(
      hostname: "localhost", username: "postgres", database: "dribbble_dev"
    )
    connection
  end
end
