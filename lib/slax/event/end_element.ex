defmodule Slax.Event.EndElement do
  @moduledoc """
  Event sent when the closing tag of an element is encountered.

  Contains the following keys:
  * local_name
  * prefix
  * uri
  """

  @enforce_keys [:local_name, :prefix, :uri]
  defstruct [:local_name, :prefix, :uri]

  @typedoc """
  Structure representing the closing tag of an element.  Contains the following keys:
  * local_name: A string
  * prefix: A string
  * uri: A string
  """
  @type t :: %__MODULE__{
    local_name: String.t,
    prefix: String.t,
    uri: String.t
  }
end
