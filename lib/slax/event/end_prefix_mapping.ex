defmodule Slax.Event.EndPrefixMapping do
  @moduledoc """
  Event sent at the end scope of a prefix - URI namespace mapping.  Will be sent immediately before the corresponding `Slax.Event.EndElement` event.

  Contains the following keys:
  * prefix - A string containing the prefix
  """

  @enforce_keys [:prefix]
  defstruct [:prefix]

  @typedoc """
  Structure representing the end scope of a prefix - URI namespace mapping.  Contains the following keys:
  * prefix - A string containing the prefix
  """
  @type t :: %__MODULE__{
    prefix: String.t
  }
end
