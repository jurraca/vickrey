defmodule Vickrey.Namebase.Record do
    @moduledoc """
    Schema for Namebase records, such as domain sale logs and current listings.
    These will have their own table, since these transactions are internal to namebase and not on-chain, and therefore represent an independent data model.
    Value is an integer and not a float, since the namebase API returns value in dollarydoos (1 HNS = 1_000_000 dollarydoos.)
    """

    use Ecto.Schema
    import Ecto.Changeset

    schema "namebase_records" do
      field :name, :string
      field :created_at, :utc_datetime
      field :action, :string
      field :value, :integer

      timestamps()
    end

    def changeset(record, attrs \\ %{}) do
        cast(record, attrs, [:name, :created_at, :action, :value])
    end

    def insert(record) do
      %Vickrey.Namebase.Record{}
      |> changeset(record)
      |> Vickrey.Repo.insert()
    end
end
