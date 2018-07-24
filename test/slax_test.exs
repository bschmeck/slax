defmodule SlaxTest do
  use ExUnit.Case
  doctest Slax

  test "greets the world" do
    assert Slax.hello() == :world
  end
end
