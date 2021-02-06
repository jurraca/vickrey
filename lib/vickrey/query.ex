defmodule Vickrey.Query do
    import Ecto.Query
    alias Vickrey.Transaction

    def get_name(name) when is_binary(name) do
      Transaction
        |> where([t], t.name == ^name)
        |> order_by([t], [asc: t.height])
    end

    def get_name_closed(name) do
      name
      |> get_name()
      |> where([t], t.action in ["FINALIZE", "REGISTER"])
    end

    def get_by_action(action)do
      Transaction
      |> where([t], t.action in ^action)
      |> order_by([t], [asc: t.height])
    end

    def get_by_action_since(action, height) do
      action
      |> get_by_action()
      |> where([t], t.height >= ^height)
    end

    def get_sold(), do: get_by_action("REGISTER")

    def get_opens(), do: get_by_action("OPEN")

    def get_bids(), do: get_by_action("BID")
end
