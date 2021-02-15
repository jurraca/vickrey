defmodule Vickrey.Namebase.Record do
    @moduledoc """
    Schema for Namebase records, such as domain sale logs and current listings.
    These will have their own table, since these transactions are internal to namebase and not on-chain, and therefore represent an independent data model.
    Value is an integer and not a float, since the namebase API returns value in dollarydoos (1 HNS = 1_000_000 dollarydoos.)
    """

    use Ecto.Schema
    import Ecto.Changeset
    alias Vickrey.Namebase.Api

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

    def fetch_records(offset) do
      offset
      |> Api.get_all_sold(sortKey: "date", sortDirection: "asc")
      |> Enum.map(fn rec -> format_record(rec) end)
      |> Enum.map(fn rec -> insert(rec) end)
    end

    defp format_record(%{"amount" => amount, "created_at" => created_at} = rec) do
      {:ok, date, 0} = DateTime.from_iso8601(created_at)

      rec
      |> Map.replace(:created_at, date)
      |> Map.put("value", amount)
      |> Map.put("action", "SOLD")
    end

    def crawl_records(start, acc \\ 0) do
      count = start
        |> fetch_records()
        |> Enum.count()

      new = acc + count
      :timer.sleep(100)
      IO.inspect(new, label: "count")
      crawl_records(start + 100, new)
    end
end
