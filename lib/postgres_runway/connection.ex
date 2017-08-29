defmodule PostgresRunway.Connection do
  use GenServer

  # Public API
  def start_link do
    { :ok, connection } = Postgrex.start_link(hostname: "localhost", username: "postgres", database: "dribbble_dev")
    GenServer.start_link(__MODULE__, connection, name: __MODULE__)
  end

  def execute(query) do
    GenServer.call __MODULE__, { :execute, query }
  end

  # GenServer stuff
  def handle_call({ :execute, query }, _from, connection) do
    { :reply, Postgrex.query!(connection, query, []), connection }
  end
end
