defmodule Vickrey.Repo.Migrations.AddUniqueHeightConstraint do
  use Ecto.Migration

  def change do
      create unique_index(:blocks, [:height])
  end
end
