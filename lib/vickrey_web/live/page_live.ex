defmodule VickreyWeb.PageLive do
  use VickreyWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    case Vickrey.RPC.get_blockchain_info() do
      nil -> {:ok, assign(socket, query: "", results: %{}, chain: "")}
      chain_data -> {:ok, assign(socket, query: "", results: %{}, chain: chain_data)}
    end
  end

  @impl true
  def handle_event("search", %{"q" => query}, socket) do
    case search(query) do
      {:ok, results} ->
        {:noreply, assign(socket, results: results)}

      _ ->
        {:noreply,
         socket
         |> put_flash(:error, "Not found.")
         |> assign(results: %{}, query: query)}
    end
  end

  def search(query) do
    query
    |> Vickrey.Names.get_name_info()
    |> format_search_results()
  end

  def format_search_results({:ok, results}) do
    {:ok, pop_and_replace(results, "stats", "stats")}
  end

  def format_search_results({:error, error}) do
    {:error, error}
  end

  defp pop_and_replace(map, key, new_key) do
    {item, new_map} = Map.pop!(map, key)
    Map.put_new(new_map, new_key, item)
  end
end
