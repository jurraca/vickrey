defmodule Vickrey.Node do
  @moduledoc """
      Implementation of the hsd-Node commands.
  """

  alias Vickrey.API

  def get_server_info(), do: API.base_get_request()

  def get_mempool_snapshot() do
    API.base_get_request("mempool")
  end

  def get_block_by_hash_or_height(hoh) do
    API.base_get_request("block/#{hoh}")
  end

  def get_tx_by_hash(hash) when is_binary(hash) do
    API.base_get_request("/tx/#{hash}")
  end

  def get_tx_by_address(address) when is_binary(address) do
    API.base_get_request("tx/address/#{address}")
  end

  def get_coins_by_address(address) when is_binary(address) do
    API.base_get_request("/coin/address/#{address}")
  end
end
