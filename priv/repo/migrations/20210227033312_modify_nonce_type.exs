defmodule Vickrey.Repo.Migrations.ModifyNonceType do
  use Ecto.Migration

  def change do
    alter table(:blocks) do
      modify :nonce, :bigint
    end
  end
end
