defmodule Vickrey.Transaction do
    use Ecto.Schema

    schema "transactions" do
        field :name, :string
        field :height, :integer
        field :action, :string
        field :value, :float
    end
end
