defmodule VickreyWeb.BidsLive do
  use VickreyWeb, :live_view

    def mount(_params, _session, socket) do
        {bids, opens} = Vickrey.Fetcher.fetch_last_block() |> filter_by_action({[], []})

        {:ok, assign(socket, bids: bids, opens: opens)}
    end

    def filter_by_action([%{action: action} = head | tail], {bids, opens}) do
      case action do
        "BID" -> filter_by_action(tail, {bids ++ [ head ], opens})
        "OPEN" -> filter_by_action(tail, { bids, opens ++ [ head ]})
        _ -> filter_by_action(tail, {bids, opens})
      end
    end

    def filter_by_action([], state), do: state
end
