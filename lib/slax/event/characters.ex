defmodule Slax.Event.Characters do
  @moduledoc """
  Event sent when character data is encountered. All character data will be in one event, except if there is a CDATA section included inside a character section. In that case there will be separate events for the characters before the CDATA, the CDATA section and the characters following it (if any, of course).

  Contains the following keys:
  * characters: A string containing the character data.
  """

  @enforce_keys [:characters]
  defstruct [:characters]

  @typedoc """
  Structure representing character data encountered while parsing.  Contains the following keys:
  * characters: A string containing the character data.
  """
  @type t :: %__MODULE__{
    characters: String.t
  }
end
