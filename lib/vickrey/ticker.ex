defmodule Vickrey.Ticker do
    @moduledoc """
        Fetch the latest n blocks, return the actions and names involved.
    """

    alias Vickrey.{RPC, Names}

    @actions ["OPEN", "BID"]

    def fetch_last_block() do
      RPC.get_best_blockhash()
      |> RPC.get_block()
      |> handle_block()
    end

    def handle_block(%{"tx" => txs}) do
      txs
      |> Enum.map(fn tx -> handle_tx(tx) end)
    end

    def handle_block(_), do: {:error, "no txs"}

    def handle_tx(%{"vout" => outputs} ) do
      outputs
      |> Enum.map(fn vout -> handle_outputs(vout) end)
      |> Enum.filter(fn item -> item != nil end)
    end

    def handle_tx(%{}), do: %{}

    def handle_outputs(%{"covenant" => cov, "value" => value}) do
      name = case cov["action"] in @actions do
        true -> get_name_from_list(cov["items"], [])
        false -> nil
      end
      format_output(name, cov["action"], value)
    end

    def handle_outputs(%{"covenant" => _}) do
      %{}
    end

    def get_name_from_list([head | tail], state) do
      if String.length(head) > 20 do
        case Names.get_name_by_hash(head) do
          {:ok, %{"result" => nil}} -> get_name_from_list(tail, state)
          {:ok, %{"result" => result}} -> get_name_from_list(tail, state ++ [result])
          {:error, _} -> get_name_from_list(tail, state)
        end
      else
        get_name_from_list(tail, state)
      end
    end

    def get_name_from_list([], state), do: state

    defp format_output(nil, _action, _value), do: nil

    defp format_output(name, action, value) do
      %{name: name, action: action, value: value}
    end
end
