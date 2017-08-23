defmodule PostgresRunwayTest do
  use ExUnit.Case
  doctest PostgresRunway

  test "greets the world" do
    assert PostgresRunway.hello() == :world
  end
end
