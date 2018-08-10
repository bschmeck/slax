defmodule Slax.Event.StartDocument do
  @moduledoc """
  Event sent when the start of the document is encountered.

  Contains no keys.
  """

  defstruct []

  @typedoc """
  Structure representing the start of a document.  Contains no keys.
  """
  @type t :: %__MODULE__{ }
end
