defmodule PromExTest do
  use ExUnit.Case
  doctest PromEx

  test "greets the world" do
    assert PromEx.hello() == :world
  end
end
