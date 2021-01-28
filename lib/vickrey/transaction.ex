defmodule Vickrey.Transaction do
    use Ecto.Schema
    import Ecto.Changeset

    schema "transactions" do
        field :name, :string
        field :height, :integer
        field :action, :string
        field :value, :float
    end

    def changeset(tx, attrs \\ %{}) do
        tx
        |> cast(attrs, [:name, :height, :action, :value])
    end

    def insert(_, {:error, msg}), do: {:error, msg}

    def insert(height, row = %{}) do
        tx = Map.put_new(row, :height, height)

        %Vickrey.Transaction{}
        |> changeset(tx)
        |> Vickrey.Repo.insert()
    end
end
