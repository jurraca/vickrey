defmodule Vickrey.API do
  @moduledoc """
  API Client.
  """

  @endpoint %URI{
    host: Application.compile_env!(:vickrey, :ip),
    port: String.to_integer(Application.compile_env!(:vickrey, :port)),
    scheme: "http"
  }

  @api_key Application.compile_env!(:vickrey, :node_api_key)

  def headers(headers \\ []) do
    auth = Base.encode64(":" <> @api_key)
    headers ++ [{"Content-Type", "application/json"}, {"Authorization", "Basic " <> auth}]
  end

  def get(path \\ "") do
    @endpoint
    |> Map.put(:path, path)
    |> URI.to_string()
    |> HTTPoison.get(headers())
    |> handle_response()
  end

  def post(body) do
    @endpoint
    |> URI.to_string()
    |> HTTPoison.post(body, headers())
    |> handle_response()
  end

  def handle_response({:ok, %HTTPoison.Response{body: body, status_code: 200}}) do
    Jason.decode(body)
  end

  def handle_response({:ok, %HTTPoison.Response{body: body, status_code: status}}) do
    {:ok, %{status_code: status, body: Jason.decode!(body)} }
  end

  def handle_response({:ok, %HTTPoison.Error{reason: reason}}) do
    {:error, reason}
  end

  def handle_response({:error, %HTTPoison.Error{reason: reason}}) do
    {:error, reason}
  end
end
