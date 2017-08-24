defmodule PostgresRunway.Sequences do
  require Logger

  def fetch do
    fetch_sequences() |> fetch_values
  end

  def fetch_sequences do
    execute(connect(), "select relname from pg_class where (relkind = 'S')").rows |> List.flatten
  end

  def fetch_values(sequence_names) do
    conn = connect()
    Logger.info("fetch_values received these sequence names")
    # Logger.info(Enum.join(sequence_names |> Enum.take(5)), ", ")
    Logger.info(inspect(sequence_names |> Enum.take(5)))
    sequence_names |> Enum.map(fn sn -> values_for_sequence conn, sn end)
  end

  def values_for_sequence(conn, sequence_name) do
    data = execute(conn, "select last_value, max_value from #{sequence_name}")
    [[last, max]] = data.rows;
    %{name: sequence_name, last: last, max: max, used: (last * 100.0 / max)}
  end

  def execute(conn, query) do
    Postgrex.query!(conn, query, [])
  end

  def connect do
    {:ok, conn} = Postgrex.start_link(hostname: "localhost", username: "postgres", database: "dribbble_dev")
    conn
  end
end
