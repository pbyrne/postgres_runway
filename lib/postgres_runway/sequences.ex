defmodule PostgresRunway.Sequences do
  require Logger

  alias PostgresRunway.Connection, as: Connection

  @moduledoc """
  Query databadse for sequences and provide usage data (current value, max
  value, and percentage used).
  """

  def fetch do
    Connection.start_link()
    fetch_sequences() |> fetch_values
  end

  def fetch_sequences do
    Connection.execute("select relname from pg_class where (relkind = 'S')").rows |> List.flatten
  end

  def fetch_values(sequence_names) do
    Logger.info("fetch_values received these sequence names")
    Logger.info(inspect(sequence_names |> Enum.take(5)))
    sequence_names |> Enum.map(fn sn -> values_for_sequence sn end)
  end

  def values_for_sequence(sequence_name) do
    data = Connection.execute("select last_value, max_value from #{sequence_name}")
    [[last, max]] = data.rows
    %{name: sequence_name, last: last, max: max, used: (last * 100.0 / max)}
  end
end
