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
    def handle(event = %Slax.Event.StartElement{}, names), do: [event.local_name | names]
  end

  defmodule EndTagCapture do
    @behaviour Slax.Parser

    use Slax.Parser, state: []
    def handle(event = %Slax.Event.EndElement{}, names), do: [event.local_name | names]
  end

  defmodule CharacterCapture do
    @behaviour Slax.Parser

    use Slax.Parser, state: []
    def handle(event = %Slax.Event.Characters{}, texts), do: [event.characters | texts]
  end

  defmodule AttributeCapture do
    @behaviour Slax.Parser

    use Slax.Parser, state: nil
    def handle(event = %Slax.Event.StartElement{}, _state), do: event.attributes
  end

  @xml "<xml><node name=\"test node\" id=\"55\">Value</node></xml>"

  test "it parses XML with text and attributes" do
    # We should get start/end for document, xml and node, plus 1 for the text
    assert Slax.parse(@xml, Counter) == {:ok, 7}
  end

  test "it accepts parameters to init" do
    # We should get start/end for document, xml and node, plus 1 for the text
    assert Slax.parse(@xml, Counter, [5]) == {:ok, 12}
  end

  test "it sends start tags to the handler" do
    assert Slax.parse(@xml, StartTagCapture) == {:ok, ~w[node xml]}
  end

  test "it sends an attribute map with start tag events" do
    assert Slax.parse(@xml, AttributeCapture) == {:ok, %{"name" => "test node", "id" => "55"}}
  end

  test "it sends end tags to the handler" do
    assert Slax.parse(@xml, EndTagCapture) == {:ok, ~w[xml node]}
  end

  test "it sends text characters to the handler" do
    assert Slax.parse(@xml, CharacterCapture) == {:ok, ~w[Value]}
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
