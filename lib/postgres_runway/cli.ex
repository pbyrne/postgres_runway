defmodule PostgresRunway.CLI do
  require Logger

  @moduledoc """
  CLI implmenetation. Queries for sequence data and formats for the screen.
  """

  def main() do
    Logger.info "MAIN"
    PostgresRunway.Sequences.fetch
    |> sort_descending
    |> display
  end

  def sort_descending(values) do
    values
    |> Enum.sort(fn %{used: used1}, %{used: used2} -> used1 <= used2 end)
    |> Enum.reverse
  end

  def display(values) do
    Logger.info "DISPLAYING"
    values |> Enum.take(10) |> Enum.each(&print_line/1)
  end

  defp print_line(record) do
    %{name: sequence, used: used} = record
    IO.puts "#{sequence}: #{Float.round(used, 2)}%"
  end
end
