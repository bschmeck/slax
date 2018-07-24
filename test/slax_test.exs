defmodule SlaxTest do
  use ExUnit.Case

  defmodule Counter do
    @behaviour Slax.Parser

    use Slax.Parser, state: 0
    def init([count]), do: count
    def handle(_, count), do: count + 1
  end

  test "it parses XML with text and attributes" do
    xml = "<xml><node name=\"test node\">Value</node></xml>"

    # We should get start/end for document, xml and node, plus 1 for the text
    assert Slax.parse(xml, Counter) == {:ok, 7}
  end

  test "it accepts parameters to init" do
    xml = "<xml><node name=\"test node\">Value</node></xml>"

    # We should get start/end for document, xml and node, plus 1 for the text
    assert Slax.parse(xml, Counter, [5]) == {:ok, 12}
  end

  test "complains about XML without a closing xml tag" do
    xml = "<xml><node name=\"test node\">Value</node>"

    # We should get start/end for document, xml and node, plus 1 for the text
    assert {:error, "Malformed: Unexpected end of data"} = Slax.parse(xml, Counter)
  end

  test "complains about XML with a missing tag" do
    xml = "<xml><node name=\"test node\">Value</xml>"

    # We should get start/end for document, xml and node, plus 1 for the text
    assert {:error, "Malformed: Tags don't match"} = Slax.parse(xml, Counter)
  end
end
