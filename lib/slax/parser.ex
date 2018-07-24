defmodule Slax.Parser do
  @callback init(arg :: any) :: any
  @callback finalize(arg :: any) :: any
  @callback handle(tuple(), arg :: any) :: any
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
