defmodule Slax.Event.StartPrefixMapping do
  @moduledoc """
  Event sent at the beginning scope of a prefix - URI namespace mapping.  Will be sent immediately before the corresponding `Slax.Event.StartElement` event.

  Contains the following keys:
  * prefix - A string containing the prefix
  * uri - A string containing the URI
  """

  @enforce_keys [:prefix, :uri]
  defstruct [:prefix, :uri]

  @typedoc """
  Structure representing the beginning scope of a prefix - URI namespace mapping.  Contains the following keys:
  * prefix - A string containing the prefix
  * uri - A string containing the URI
  """
  @type t :: %__MODULE__{
    prefix: String.t,
    uri: String.t
  }
end
