defmodule Slax.Event.ProcessingInstruction do
  @moduledoc """
  Event sent when a processing instruction is encountered during parsing.

  Contains the following keys:
  * data - A string containing the processing instructions
  * target - A string containing the target of the processing instructions
  """

  @enforce_keys [:data, :target]
  defstruct [:data, :target]

  @typedoc """
  Structure representing processing instructions in a document.  Contains the following keys:
  * data - A string containing the processing instructions
  * target - A string containing the target of the processing instructions
  """
  @type t :: %__MODULE__{
    data: String.t,
    target: String.t
  }
end
