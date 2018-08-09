# Slax

Slax is a SAX parser for XML documents, built atop the [`erlsom`](https://github.com/willemdj/erlsom) parser.

## Usage

To begin parsing, pass an IO object or string, along with a parser module and (optional) initial state to the `Slax.parse/3` function.

The parser module should include a `handle/3` function head for any event it wishes to handle.  The function will receive an event struct containing relevant data for the current portion of the XML being parsed, as well as whatever ancillary state has been accumulated.  The return value of the function call will be passed to the following invocation of `handle/2` as the new state.  If no function clause matches the supplied arguments, the previous state will be preserved and supplied to the next invocation of `handle/3`.

### Parser Modules

Use of the `Slax.Parser` module can simplify the construction of parser modules:

* The `@behaviour Slax.Parser` declaration will ensure that your module defines the proper functions with the correct arity.
* The `use Slax.Parser` declaration will provide default implementations of the required functions, allowing your parser to only define the handlers it needs.

An example parser that will write all text in a XML document to standard out looks like:

```
defmodule StdoutParser do
  @behaviour Slax.Parser

  use Slax.Parser

  def handle(%Slax.Event.Characters{characters: chars}, _), do: IO.puts chars
end
```

The parser module's `init` function will be called prior to start of parsing.  The optional `state` keyword can be used in conjunction with the `use` declaration to provide an argument to the `init` function:

```
defmodule StateParser do
  @behaviour Slax.Parser

  use Slax.Parser, state: 55

  def init([value]), do: value * 2 # Will set initial state to 110
end
```

### Events

Slax defines a struct for each kind of event that can possibly be generated:

* `Slax.Event.StartDocument`
* `Slax.Event.EndDocument`
* `Slax.Event.StartPrefixMapping`
* `Slax.Event.EndPrefixMapping`
* `Slax.Event.StartElement`
* `Slax.Event.EndElement`
* `Slax.Event.Characters`
* `Slax.Event.IgnorableWhitespace`
* `Slax.Event.ProcessingInstruction`
* `Slax.Event.Error`
* `Slax.Event.InternalError`

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `slax` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:slax, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/slax](https://hexdocs.pm/slax).
