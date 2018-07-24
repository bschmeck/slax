defmodule SlaxTest do
  use ExUnit.Case

  defmodule Counter do
    @behaviour Slax.Parser

    use Slax.Parser, state: 0
    def init([count]), do: count
    def handle(_, count), do: count + 1
  end

  defmodule StartTagCapture do
    @behaviour Slax.Parser

    use Slax.Parser, state: []
    def handle({:startElement, _, name, _, _}, names), do: [name | names]
  end

  defmodule EndTagCapture do
    @behaviour Slax.Parser

    use Slax.Parser, state: []
    def handle({:endElement, _, name, _}, names), do: [name | names]
  end

  defmodule CharacterCapture do
    @behaviour Slax.Parser

    use Slax.Parser, state: []
    def handle({:characters, text}, texts), do: [text | texts]
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

  test "it sends start tags to the handler" do
    xml = "<xml><node name=\"test node\">Value</node></xml>"
    assert Slax.parse(xml, StartTagCapture) == {:ok, ['node', 'xml']}
  end

  test "it sends end tags to the handler" do
    xml = "<xml><node name=\"test node\">Value</node></xml>"
    assert Slax.parse(xml, EndTagCapture) == {:ok, ['xml', 'node']}
  end

  test "it sends text characters to the handler" do
    xml = "<xml><node name=\"test node\">Value</node></xml>"
    assert Slax.parse(xml, CharacterCapture) == {:ok, ['Value']}
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
