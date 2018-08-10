defmodule Slax.Event.InternalError do
  @moduledoc """
  Event sent when an internal error is encountered while parsing.

  Contains the following keys:
  * description - A string describing the error
  """

  @enforce_keys [:description]
  defstruct [:description]

  @typedoc """
  Structure representing an internal error encountered while parsing.  Contains the following keys:
  * description - A string describing the error
  """
  @type t :: %__MODULE__{
    description: String.t
  }
end
