defmodule Vickrey.Query do
    import Ecto.Query
    alias Vickrey.{Transaction, Namebase.Record, Repo}

    def max_height(), do: Transaction |> select([t], max(t.height))

    def get_name_txs(name) when is_binary(name) do
      Transaction
        |> where([t], t.name == ^name)
        |> order_by([t], [asc: t.height])
    end

    def get_name_closed(name) do
      name
      |> get_name_txs()
      |> where([t], t.action == ["REGISTER", "FINALIZE", "TRANSFER"])
    end

    def get_name_transferred(name) do
      name
      |> get_name_txs()
      |> where([t], t.action in ["FINALIZE", "TRANSFER"])
    end

    def get_by_action(action)do
      Transaction
      |> where([t], t.action == ^action)
    end

    def get_by_action(action, exclude: true)do
      Transaction
      |> where([t], t.action != ^action)
    end

    def get_by_action_since(action, height) do
      action
      |> get_by_action()
      |> where([t], t.height >= ^height)
    end

    def with_sold(query) do
      query |> join(:left, [t], s in Record, on: s.name == t.name)
    end

    def get_sold(name) when is_binary(name) do
      Record
      |> where([r], r.name == ^name)
    end

    def get_auction_closes(), do: get_by_action("REGISTER")

    def get_opens(), do: get_by_action("OPEN")

    def get_bids(), do: get_by_action("BID")

    def get_latest_block_bids(height_lookback) do
      "BID"
      |> get_by_action_since(height_lookback)
      |> order_by([t], [desc: t.height])
      |> limit(100)
    end

    def get_auctions_by_name_and_type(action, name_length) do
      Transaction
      |> where([t], t.action == ^action)
      |> where([t], fragment("char_length(?)", t.name) < ^name_length)
      |> order_by([t], [desc: t.height])
      |> limit(150)
      |> Repo.all()
    end

    def get_all_names() do
      Transaction
      |> order_by([t], [asc: t.height])
      |> distinct([t], t.name)
      |> select([t], t.name)
    end
end
