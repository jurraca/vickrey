defmodule Vickrey.Namebase.Api do
  @moduledoc """
  https://github.com/namebasehq/api-documentation/blob/master/marketplace-api.md
  """

  @endpoint "www.namebase.io/api/"

  @marketplace_endpoint %URI{
    host: @endpoint <> "v0/marketplace",
    scheme: "https"
  }

  @sold_endpoint %URI{
    host: @endpoint <> "domains/sold",
    scheme: "https"
  }

  @listings_endpoint %URI{
    host: @endpoint <> "domains/marketplace",
    scheme: "https"
  }

    def get_name_history(name) when is_binary(name) do
        get(@marketplace_endpoint, "/#{name}/history")
    end

    @doc """
    Returns the first 100 responses by offset. Use params to filter the response.
    """
    def get_all_sold(offset \\ 1000, params \\ []) do
      params = URI.encode_query(params)

      get(@sold_endpoint, "/" <> Integer.to_string(offset), params)
    end

    @doc """
    Returns the first 100 responses by offset. Use params to filter the response.
    """
    def get_all_listings(offset \\ 1000, params \\ []) do
      params = URI.encode_query(params)

      get(@listings_endpoint, "/" <> Integer.to_string(offset), params)
    end

    def get(endpoint, path \\ nil, params) when is_binary(params) do
    endpoint
      |> Map.put(:path, path)
      |> Map.put(:query, params)
      |> URI.to_string()
      |> HTTPoison.get()
      |> handle_response()
    end

    defp handle_response({:ok, %HTTPoison.Response{body: body, status_code: 200}}) do
        body
        |> Jason.decode()
        |> handle_body()
    end

    defp handle_response({:ok, %HTTPoison.Response{body: _, status_code: status}}) do
      {:error, status}
  end

  defp handle_body({:ok, %{"success" => true, "history" => history}} ), do: history

  defp handle_body({:ok, %{"success" => true, "domains" => domains}} ), do: domains

  defp handle_body({:error, _} = err), do: err
end
