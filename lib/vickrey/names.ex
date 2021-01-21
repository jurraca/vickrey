defmodule Vickrey.Names do
  @moduledoc """
  Maps to the Names RPC commands.
  """

  alias Vickrey.API

  def get_name_info(name) when is_binary(name) do
    body = %{method: "getnameinfo", params: [name]} |> Jason.encode!()

    body
    |> API.base_post_request()
    |> Vickrey.RPC.handle_response()
    |> filter_name_resp()
  end

  defp filter_name_resp(%{"info" => info}) do
    {:ok,
     Map.take(info, [
       "name",
       "nameHash",
       "state",
       "height",
       "value",
       "highest",
       "claimed",
       "stats"
     ])}
  end

  defp filter_name_resp({:ok, %{error: error}}), do: {:error, error}

  defp filter_name_resp({:error, %{"message" => error}}), do: {:error, error}

  def get_name_by_hash(hash) when is_binary(hash) do
    body = %{method: "getnamebyhash", params: [hash]} |> Jason.encode!()

    body
    |> API.base_post_request()
  end
end
