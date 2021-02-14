defmodule Vickrey.Node do
  @moduledoc """
      Implementation of the hsd-Node commands.
  """

  alias Vickrey.API

  def get_server_info(), do: API.get()

  def get_mempool_snapshot() do
    API.get("mempool")
  end

  def get_block_by_hash_or_height(hoh) do
    API.get("block/#{hoh}")
  end

  def get_tx_by_hash(hash) when is_binary(hash) do
    API.get("/tx/#{hash}")
  end

  def get_tx_by_address(address) when is_binary(address) do
    API.get("tx/address/#{address}")
  end

  def get_coins_by_address(address) when is_binary(address) do
    API.get("/coin/address/#{address}")
  end
end
