defmodule Vickrey.Repo.Migrations.MakeValueBigint do
  use Ecto.Migration

  def change do
    alter table(:namebase_records) do
      modify :value, :bigint
    end
  end
end
