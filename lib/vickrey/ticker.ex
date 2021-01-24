defmodule Vickrey.Ticker do
  @moduledoc """
      Fetch the latest n blocks, return the actions and names involved.
  """

  alias Vickrey.{RPC, Names}

  @bids ["OPEN", "BID"]
  @sold ["CLOSED", "FINALIZE", "TRANSFER"]
  @renew ["RENEW"]
  @revoke ["REVOKE"]

  def fetch_block(blockhash) when is_binary(blockhash) do
    blockhash
    |> RPC.get_block()
    |> handle_block()
  end

  def fetch_block(blockheight) when is_integer(blockheight) do
    blockheight
    |> RPC.get_block_by_height()
    |> handle_block()
  end

  def fetch_last_block() do
    RPC.get_best_blockhash()
    |> fetch_block()
  end

  def fetch_last_n_blocks(n) do
    height = RPC.get_block_count()
    fetch_blocks_since(height, n)
  end

  def fetch_blocks_since(height, n) do
    blocks = (height + 1 - n)..height

    Enum.map(blocks, fn blockheight -> fetch_block(blockheight) end)
  end

  def fetch_last_bids(n \\ 10) do
    blocks = fetch_last_n_blocks(n)

    Enum.map(blocks, fn block -> Enum.filter(
      block, fn row -> row.action in @bids end)
    end)
  end

  def fetch_last_sold(n \\ 10) do
    blocks = fetch_last_n_blocks(n)

    Enum.map(blocks, fn block -> Enum.filter(
      block, fn row -> row.action in @sold end)
    end)
  end

  def fetch_last_renewals(n \\ 10) do
    blocks = fetch_last_n_blocks(n)
    Enum.map(blocks, fn block -> Enum.filter(
      block, fn row -> row.action in @renew end)
    end)
  end

  def fetch_last_revoke(n \\ 10) do
    blocks = fetch_last_n_blocks(n)

    blocks
    |> Enum.map(fn block -> Enum.filter(block, fn row -> row.action in @revoke end) end)
  end

  def handle_block(%{"tx" => txs}) do
    txs
    |> Enum.map(fn tx -> handle_tx(tx) end)
    |> List.flatten()
  end

  def handle_block(_), do: {:error, "no txs"}

  def handle_tx(%{"vout" => outputs}) do
    outputs
    |> Enum.map(fn vout -> handle_outputs(vout) end)
    |> Enum.filter(fn item -> item != nil end)
    |> List.flatten()
  end

  def handle_tx(%{}), do: %{}

  def handle_outputs(%{"covenant" => cov, "value" => value}) do
    name =
      case cov["action"] != "NONE" do
        true -> get_name_from_list(cov["items"], [])
        false -> nil
      end

    format_output(name, cov["action"], value)
  end

  def handle_outputs(%{"covenant" => _}) do
    %{}
  end

  def get_name_from_list([head | tail], state) do
    if String.length(head) > 20 do
      case Names.get_name_by_hash(head) do
        {:ok, %{"result" => nil}} -> get_name_from_list(tail, state)
        {:ok, %{"result" => result}} -> get_name_from_list(tail, state ++ [result])
        {:error, _} -> get_name_from_list(tail, state)
      end
    else
      get_name_from_list(tail, state)
    end
  end

  def get_name_from_list([], state), do: state

  defp format_output(nil, _action, _value), do: nil

  defp format_output(name, action, value) do
    %{name: name, action: action, value: value}
  end
end
