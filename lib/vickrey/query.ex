defmodule Vickrey.Query do
    import Ecto.Query
    alias Vickrey.{Repo, Transaction}

    def get_name(name) when is_binary(name) do
      Transaction
        |> where([t], t.name == ^name)
        |> order_by([t], [asc: t.height])
        |> Repo.all()
    end

    def get_name_closed(name) do
      name
      |> get_name()
      |> Enum.filter(fn %Vickrey.Transaction{action: action} -> action in ["FINALIZE", "REGISTER"] end)
    end

    def get_all_by_action(action) do
      Transaction
      |> where([t], t.action == ^action)
      |> order_by([t], [asc: t.height])
    end

    def get_all_sold() do
      get_all_by_action("CLOSED")
    end

    def get_all_open() do
      get_all_by_action("OPEN")
    end

    def get_all_open_since(height) do
      get_all_open()
      |> where([t], t.height >= ^height)
    end
end
