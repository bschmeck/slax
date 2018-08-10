defmodule Slax.Event.EndDocument do
  @moduledoc """
  Event sent when the end of the document is encountered.  Will not be sent if an error occurs while processing.

  Contains no keys.
  """
  defstruct []

  @typedoc """
  Structure representing the end of a document.  Contains no keys.
  """
  @type t :: %__MODULE__{ }
end
