defmodule Vickrey.Block do
  use Ecto.Schema
  import Ecto.Changeset
  alias Vickrey.Repo

  schema "blocks" do
    field :height, :integer
    field :chainwork, :string
    field :difficulty, :float
    field :hash, :string
    field :merkleroot, :string
    field :nTx, :integer
    field :nonce, :integer
    field :time, :integer
    field :size, :integer
    field :weight, :integer
    field :bits, :string
    has_many :transactions, Vickrey.Transaction, foreign_key: :height, references: :height

    timestamps()
  end

  def changeset(attrs \\ %{}) do
    %__MODULE__{}
    |> cast(attrs, [:height, :chainwork, :difficulty, :hash, :merkleroot, :nTx, :nonce, :time, :size, :weight, :bits])
    |> unique_constraint(:height)
  end

  def insert(block = %{}) do
    block
    |> changeset()
    |> Repo.insert()
  end
end

defmodule Vickrey.Block.Loader do
  alias Vickrey.RPC
  alias Vickrey.Block

  def load(start, finish) do
    start..finish
    |> Stream.map(fn height -> RPC.get_block_by_height(height) end)
    |> Stream.map(fn block -> Block.insert(block) end)
    |> Enum.count(fn {x, _} -> :ok == x end)
  end

  def load_all() do
    current_height = RPC.get_block_count()
    load(0, current_height)
  end
end
