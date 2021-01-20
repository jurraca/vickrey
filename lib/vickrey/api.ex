defmodule Vickrey.Api do
  def get_server_info(address, headers) do
    "http://#{address}"
    |> HTTPoison.get(headers)
    |> handle_response()
  end

  def get_name_info(address, headers, name) when is_binary(name) do
    url = "http://#{address}"
    body = %{method: "getnameinfo", params: [name]} |> Jason.encode!()

    url
    |> HTTPoison.post(body, headers)
    |> handle_response()
    |> filter_name_resp()
  end

  defp filter_name_resp({:ok, %{"result" => %{"info" => info}}}) do
    Map.take(info, ["name", "nameHash", "state", "height", "value", "highest", "claimed", "stats"])
  end

  def get_name_by_hash(address, headers, hash) when is_binary(hash) do
    url = "http://#{address}"
    body = %{method: "getnamebyhash", params: [hash]} |> Jason.encode!()

    url
    |> HTTPoison.post(body, headers)
    |> handle_response()
  end

  def handle_response({:ok, %HTTPoison.Response{body: body, status_code: 200}}) do
    Jason.decode(body)
  end

  def handle_response({:ok, %HTTPoison.Response{body: body, status_code: status}}) do
    %{status_code: status, body: Jason.decode(body)}
  end
end
