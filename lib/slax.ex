defmodule Slax do
  defstruct [:module, :state]

  alias Slax.Event.Characters
  alias Slax.Event.EndElement
  alias Slax.Event.StartElement

  @chunk_size 10_000

  def parse(io, module, options \\ [])

  def parse(string, module, options) when is_binary(string) do
    {:ok, pid} = string |> StringIO.open()
    parse(pid, module, options)
  end

  def parse(io, module, options) do
    slax_state = %Slax{module: module, state: initial_state(module, options)}

    try do
      {:ok, slax_state = %Slax{}, _rest} =
        :erlsom.parse_sax("", slax_state, &handler/2, [
          {:continuation_function, &next_chunk/2, io}
        ])

      finalize(slax_state)
    catch
      {:error, message} -> {:error, to_string(message)}
    end
  end

  defp initial_state(module, options) do
    try do
      module.init(options)
    rescue
      UndefinedFunctionError -> module.default_init(options)
      FunctionClauseError -> module.default_init(options)
    end
  end

  defp finalize(%Slax{state: state, module: module}) do
    try do
      {:ok, module.finalize(state)}
    rescue
      FunctionClauseError -> {:ok, state}
    end
  end

  defp next_chunk(tail, io) do
    case IO.read(io, @chunk_size) do
      :eof ->
        {tail, io}

      data ->
        {<<tail::binary, data::binary>>, io}
    end
  end

  defp handler(elt, slax_state = %Slax{module: mod, state: mod_state}) do
    try do
      new_state = elt |> struct_for |> mod.handle(mod_state)
      %Slax{slax_state | state: new_state}
    rescue
      FunctionClauseError -> slax_state
    end
  end

  defp struct_for({:startElement, uri, local_name, prefix, attributes}) do
    %StartElement{attributes: attributes, local_name: to_string(local_name), prefix: to_string(prefix), uri: to_string(uri)}
  end
  defp struct_for({:endElement, uri, local_name, prefix}) do
    %EndElement{local_name: to_string(local_name), prefix: to_string(prefix), uri: to_string(uri)}
  end
  defp struct_for({:characters, chars}), do: %Characters{characters: to_string(chars)}
  defp struct_for(elt), do: elt
end
