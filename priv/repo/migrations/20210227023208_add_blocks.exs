defmodule Vickrey.Repo.Migrations.AddBlocks do
  use Ecto.Migration

  def change do
    create table(:blocks) do
      add :height, :integer
      add :chainwork, :string
      add :difficulty, :float
      add :hash, :string
      add :merkleroot, :string
      add :nTx, :integer
      add :nonce, :integer
      add :time, :integer
      add :size, :integer
      add :weight, :integer
      add :bits, :string

      timestamps()
    end
  end
end
