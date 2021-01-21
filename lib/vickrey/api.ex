defmodule Vickrey.API do
  @moduledoc """
  Main API utilities.
  """
  alias Vickrey.API.Utils

  def base_request(addr) do
    headers = Utils.headers()

    addr
    |> HTTPoison.get(headers)
    |> handle_response()
  end

  def base_get_request() do
    addr = Utils.get_node_address()

    "http://#{addr}"
    |> base_request()
  end

  def base_get_request(opts) do
    addr = Utils.get_node_address()

    "http://#{addr}/#{opts}"
    |> base_request()
  end

  def base_post_request(body) do
    addr = Utils.get_node_address()
    headers = Utils.headers()

    "http://#{addr}"
    |> HTTPoison.post(body, headers)
    |> handle_response()
  end

  def handle_response({:ok, %HTTPoison.Response{body: body, status_code: 200}}) do
    Jason.decode(body)
  end

  def handle_response({:ok, %HTTPoison.Response{body: body, status_code: status}}) do
    %{status_code: status, body: Jason.decode(body)}
  end

  def handle_response({:ok, %HTTPoison.Error{reason: reason}}) do
    {:error, reason}
  end

  def handle_response({:error, %HTTPoison.Error{reason: reason}}) do
    {:error, reason}
  end
end
