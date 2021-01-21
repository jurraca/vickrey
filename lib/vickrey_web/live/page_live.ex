defmodule VickreyWeb.PageLive do
  use VickreyWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    case Vickrey.RPC.get_blockchain_info() do
      {:ok, chain_data} -> {:ok, assign(socket, query: "", results: %{}, chain: chain_data)}
      msg -> {:ok, assign(socket, query: "", results: %{}, chain: msg)}
    end
  end

  @impl true
  def handle_event("search", %{"q" => query}, socket) do
    case search(query) do
      {:ok, results} -> {:noreply, assign(socket, results: results)}

      _ ->
        {:noreply,
         socket
         |> put_flash(:error, "Not found.")
         |> assign(results: %{}, query: query)}
    end
  end

  defp search(query) do
    query
    |> Vickrey.Names.get_name_info()
    |> format_search_results()
  end

  defp format_search_results({:ok, results}) do
    {stats, new_results} = Map.pop!(results, "stats")
    {:ok, Map.merge(stats, new_results)}
  end

  defp format_search_results({:error, error}) do
    {:error, error}
  end
end
