defmodule Slax.Parser do
  alias Slax.Event.{Characters, EndDocument, EndElement, EndPrefixMapping, Error, IgnorableWhitespace, InternalError, ProcessingInstruction, StartDocument, StartElement, StartPrefixMapping}

  @callback init(arg :: any) :: any
  @callback finalize(arg :: any) :: any
  @callback handle(arg :: (Characters.t | EndDocument.t | EndElement.t | EndPrefixMapping.t | Error.t | IgnorableWhitespace.t | InternalError.t | ProcessingInstruction.t | StartDocument.t | StartElement.t | StartPrefixMapping.t), arg :: any) :: any
  @optional_callbacks init: 1

  defmacro __using__(opts \\ []) do
    quote do
      def default_init(_args), do: unquote(opts[:state])
      def finalize(state), do: state
      def handle(_, state), do: state

      defoverridable handle: 2, finalize: 1
    end
  end
end
