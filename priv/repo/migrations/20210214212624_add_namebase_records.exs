defmodule Vickrey.Repo.Migrations.AddNamebaseRecords do
  use Ecto.Migration

  def change do
    create table(:namebase_records) do
      add :name, :string
      add :created_at, :utc_datetime
      add :action, :string
      add :value, :integer

      timestamps()
    end
  end

  def down do
    drop table("namebase_records")
  end
end
