defmodule Vickrey.Names do
  @moduledoc """
  Maps to the Names RPC commands.
  """

  alias Vickrey.API

  def get_name_info(name) when is_binary(name) do
    body = %{method: "getnameinfo", params: [name]} |> Jason.encode!()

    body
    |> API.base_post_request()
    |> filter_name_resp()
  end

  defp filter_name_resp({:ok, %{"result" => %{"info" => info}}}) do
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

  def get_name_by_hash(hash) when is_binary(hash) do
    body = %{method: "getnamebyhash", params: [hash]} |> Jason.encode!()

    body
    |> API.base_post_request()
  end
end
