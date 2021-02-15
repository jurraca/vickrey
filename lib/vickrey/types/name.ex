defmodule Vickrey.Name do
    use Ecto.Schema
    import Ecto.Changeset

    schema "names" do
        field :name, :string
        field :namehash, :string
        has_many :namebase_records, Vickrey.Namebase.Record, foreign_key: :name
        has_many :transactions, Vickrey.Transaction, foreign_key: :name
    end

    def changeset(name, params \\ %{}) do
      name
      |> cast(params, [:name, :namehash])
      |> unique_constraint(:name)
    end
end
