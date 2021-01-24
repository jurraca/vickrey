defmodule Vickrey.RPC do
  @moduledoc """
      Implementation of the RPC methods.
  """

  alias Vickrey.API

  def get_blockchain_info() do
    body = Jason.encode!(%{method: "getblockchaininfo"})

    body
    |> API.base_post_request()
    |> handle_response()
  end

  def get_best_blockhash() do
    body = Jason.encode!(%{method: "getbestblockhash"})

    body
    |> API.base_post_request()
    |> handle_response()
  end

  def get_block_count() do
    body = Jason.encode!(%{method: "getblockcount"})

    body
    |> API.base_post_request()
    |> handle_response()
  end

  def get_block(blockhash, verbose \\ 1, details \\ 1) do
    body = Jason.encode!(%{method: "getblock", params: [blockhash, verbose, details]})

    body
    |> API.base_post_request()
    |> handle_response()
  end

  def get_block_by_height(blockheight, verbose \\ 1, details \\ 1) do
    body = Jason.encode!(%{method: "getblockbyheight", params: [blockheight, verbose, details]})

    body
    |> API.base_post_request()
    |> handle_response()
  end

  def get_block_hash(blockheight) do
    body = Jason.encode!(%{method: "getblockhash", params: [blockheight]})

    body
    |> API.base_post_request()
    |> handle_response()
  end

  def get_block_header(blockhash, verbose \\ 1) when is_binary(blockhash) do
    body = Jason.encode!(%{method: "getblockheader", params: [blockhash, verbose]})

    body
    |> API.base_post_request()
    |> handle_response()
  end

  def get_chain_tips() do
    body = Jason.encode!(%{method: "getchaintips"})

    body
    |> API.base_post_request()
    |> handle_response()
  end

  def get_difficulty() do
    body = Jason.encode!(%{method: "getdifficulty"})

    body
    |> API.base_post_request()
    |> handle_response()
  end

  def get_network_hash_ps(blocks, height) do
    body = Jason.encode!(%{method: "getnetworkhashps", params: [blocks, height]})

    body
    |> API.base_post_request()
    |> handle_response()
  end

  def get_mining_info() do
    body = Jason.encode!(%{method: "getmininginfo"})

    body
    |> API.base_post_request()
    |> handle_response()
  end

  def handle_response({:ok, %{"error" => nil, "result" => result}}) do
    result
  end

  def handle_response({:ok, %{"error" => error, "result" => _result}}) do
    {:error, error}
  end

  def handle_response({:error, %{"error" => error}}) do
    {:error, error}
  end

  def handle_response(msg), do: {:error, msg}
end
