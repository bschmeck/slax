defmodule Slax.Event.EndElement do
  @enforce_keys [:local_name, :prefix, :uri]
  defstruct [:local_name, :prefix, :uri]
end
