defmodule Slax.Event.IgnorableWhitespace do
  @moduledoc """
  Event sent when ignorable whitespace is encountered during parsing.

  Contains the following keys:
  * characters - A string containing the whitespace characters encountered
  """

  @enforce_keys [:characters]
  defstruct [:characters]

  @typedoc """
  Structure representing ignorable whitespace in a document.  Contains the following keys:
  * characters: A string containing the whitespace characters encountered
  """
  @type t :: %__MODULE__{
    characters: String.t
  }

end
