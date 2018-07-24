defmodule Slax.Event.StartElement do
  @enforce_keys [:attributes, :local_name, :prefix, :uri]
  defstruct [:attributes, :local_name, :prefix, :uri]
end
