defmodule PostgresRunway.CLI do
  require Logger

  def main() do
    Logger.info "MAIN"
    PostgresRunway.Sequences.fetch
    |> sort_descending
    |> display
  end

  def sort_descending(values) do
    Enum.sort(values, fn %{used: used1}, %{used: used2} -> used1 <= used2 end)
    |> Enum.reverse
  end

  def display(values) do
    Logger.info "DISPLAYING"
    values |> Enum.take(10) |> Enum.each(&print_line/1)
  end

  defp print_line(record) do
    %{ name: sequence, used: used } = record
    IO.puts "#{sequence}: #{Float.round(used, 2)}%"
  end
end
