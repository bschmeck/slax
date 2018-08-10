defmodule Slax.Event.Error do
  @moduledoc """
  Event sent when an error is encountered while parsing.

  Contains the following keys:
  * description - A string describing the error
  """

  @enforce_keys [:description]
  defstruct [:description]

  @typedoc """
  Structure representing an error encountered while parsing.  Contains the following keys:
  * description - A string describing the error
  """
  @type t :: %__MODULE__{
    description: String.t
  }
end
