defmodule VickreyWeb.PageLive do
  use VickreyWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    # on mount, query blockchain status
    chain_data = case Vickrey.RPC.get_blockchain_info() do
      {:ok, chain_data} -> chain_data
      msg -> msg
    end

    {:ok, assign(socket, query: "", results: %{}, chain: chain_data)}
  end

  @impl true
  def handle_event("suggest", %{"q" => query}, socket) do
    {:noreply, assign(socket, results: search(query), query: query)}
  end

  @impl true
  def handle_event("search", %{"q" => query}, socket) do
    case search(query) do
      {:ok, results} -> {:noreply, assign(socket, results: results)}

      _ ->
        {:noreply,
         socket
         |> put_flash(:error, "No dependencies found matching \"#{query}\"")
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

end
