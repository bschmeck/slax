defmodule Slax.Event.StartElement do
  @moduledoc """
  Event sent when the opening tag of an element is encountered.  There will be a corresponding `Slax.Event.EndElement` event, even when the element is empty.

  Contains the following keys:
  * attributes - A map of attribute records.  Namespace attributes (`xmlns:*`) will not be reported.  There will be NO attribute values for defaulted attributes!
  * local_name
  * prefix
  * uri
  """

  @enforce_keys [:attributes, :local_name, :prefix, :uri]
  defstruct [:attributes, :local_name, :prefix, :uri]

  @typedoc """
  Structure representing the opening tag of an element.  Contains the following keys:
  * attributes - A map of attribute records.  Namespace attributes (`xmlns:*`) will not be reported.  There will be NO attribute values for defaulted attributes!
  * local_name: A string
  * prefix: A string
  * uri: A string
  """
  @type t :: %__MODULE__{
    attributes: map(),
    local_name: String.t,
    prefix: String.t,
    uri: String.t
  }
end
