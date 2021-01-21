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
        Enum.map(outputs, fn vout -> handle_outputs(vout) end)
    end

    def handle_tx(%{}), do: %{}

    def handle_outputs(%{"covenant" => cov, "value" => value}) do
      name = case cov["action"] in @actions do
        true -> get_name_from_list(cov["items"], [])
        false -> nil
      end

      %{name: name, action: cov["action"], value: value}
    end

    def handle_outputs(%{"covenant" => _}) do
      %{}
    end

    def get_name_from_list([head | tail], state) do
      if String.length(head) > 20 do
        name = Names.get_name_by_hash(head)
        get_name_from_list(tail, state ++ [name])
      else
        get_name_from_list(tail, state)
      end
    end

    def get_name_from_list([], state), do: state
end
