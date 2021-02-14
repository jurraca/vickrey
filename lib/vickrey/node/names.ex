defmodule Vickrey.Names do
  @moduledoc """
  Maps to the Names RPC commands.
  """

  alias Vickrey.{API, RPC}

  def get_name_info(name) when is_binary(name) do
    %{method: "getnameinfo", params: [name]}
    |> Jason.encode!()
    |> API.post()
    |> RPC.handle_response()
    |> filter_name_resp()
  end

  def get_name_info(_), do: {:error, "Argument must be a binary -- a name."}

  defp filter_name_resp(%{"info" => nil}), do: {:ok, "Not found."}

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
    %{method: "getnamebyhash", params: [hash]}
    |> Jason.encode!()
    |> API.post()
  end

  def get_name_by_hash(_), do: {:error, "Argument must be a binary -- a hash of a name."}
end
