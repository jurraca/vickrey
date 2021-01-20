defmodule Vickrey.RPC do
  @moduledoc """
      Implementation of the RPC methods.
  """

  alias Vickrey.API

  def get_blockchain_info() do
    body = Jason.encode!(%{method: "getblockchaininfo"})
    API.base_post_request(body)
  end

  def get_best_blockhash() do
    body = Jason.encode!(%{method: "getbestblockhash"})
    API.base_post_request(body)
  end

  def get_block_count() do
    body = Jason.encode!(%{method: "getblockcount"})
    API.base_post_request(body)
  end

  def get_block(blockhash, verbose \\ 1, details \\ 1) do
    body = Jason.encode!(%{method: "getblock", params: [blockhash, verbose, details]})
    API.base_post_request(body)
  end

  def get_block_by_height(blockheight, verbose \\ 1, details \\ 1) do
    body = Jason.encode!(%{method: "getblock", params: [blockheight, verbose, details]})
    API.base_post_request(body)
  end

  def get_block_hash(blockheight) do
    body = Jason.encode!(%{method: "getblockhash", params: [blockheight]})
    API.base_post_request(body)
  end

  def get_block_header(blockhash, verbose \\ 1) when is_binary(blockhash) do
    body = Jason.encode!(%{method: "getblockheader", params: [blockhash, verbose]})
    API.base_post_request(body)
  end

  def get_chain_tips() do
    body = Jason.encode!(%{method: "getchaintips"})
    API.base_post_request(body)
  end

  def get_difficulty() do
    body = Jason.encode!(%{method: "getdifficulty"})
    API.base_post_request(body)
  end

  def get_network_hash_ps(blocks, height) do
    body = Jason.encode!(%{method: "getnetworkhashps", params: [blocks, height]})
    API.base_post_request(body)
  end

  def get_mining_info() do
    body = Jason.encode!(%{method: "getmininginfo"})
    API.base_post_request(body)
  end
end