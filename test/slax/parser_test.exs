defmodule Slax.ParserTest do
  use ExUnit.Case

  defmodule EmptyParser do
    @behaviour Slax.Parser

    use Slax.Parser, state: :test_state
  end

  defmodule NoStateParser do
    @behaviour Slax.Parser

    use Slax.Parser
  end

  defmodule CustomInitParser do
    @behaviour Slax.Parser

    use Slax.Parser

    def init(_args), do: 1 + 1
  end

  defmodule MatchingInitParser do
    @behaviour Slax.Parser

    use Slax.Parser, state: 3

    def init(state: 12), do: 12
  end

  defmodule StartCounter do
    @behaviour Slax.Parser

    use Slax.Parser, state: 0

    def handle({:startElement, _, _, _, _}, count), do: count + 1
  end

  @xml "<xml><node name=\"test node\">Value</node></xml>"

  test "it provides a default implementation for a parser" do
    assert {:ok, _} = Slax.parse(@xml, EmptyParser)
  end

  test "it accepts an initial state" do
    assert {:ok, :test_state} = Slax.parse(@xml, EmptyParser)
  end

  test "it doesn't require an initial state" do
    assert {:ok, nil} = Slax.parse(@xml, NoStateParser)
  end

  test "it allows the initialize method to be overridden" do
    assert {:ok, 2} = Slax.parse(@xml, CustomInitParser)
  end

  test "it falls back to the default initialize method" do
    assert {:ok, 3} = Slax.parse(@xml, MatchingInitParser)
    assert {:ok, 12} = Slax.parse(@xml, MatchingInitParser, state: 12)
  end

  test "it falls back to the default handle method" do
    assert {:ok, 2} = Slax.parse(@xml, StartCounter)
  end
end
