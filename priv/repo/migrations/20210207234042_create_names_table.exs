defmodule Vickrey.Repo.Migrations.CreateNamesTable do
  use Ecto.Migration

  def change do
    create table(:names) do
      add :name, :string
      add :namehash, :string

      timestamps()
    end

    create unique_index(:names, [:name])
  end
end
