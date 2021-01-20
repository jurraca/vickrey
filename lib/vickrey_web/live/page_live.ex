defmodule VickreyWeb.PageLive do
  use VickreyWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    # on mount, query blockchain status
    chain_data = case {:ok, %{blocks: 10000, chain: "main", bestblockhash: "0001", difficulty: 999}} do #Vickrey.RPC.get_blockchain_info() do
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
      {:ok, result} -> {:noreply, assign(socket, result: result)}

      _ ->
        {:noreply,
         socket
         |> put_flash(:error, "No dependencies found matching \"#{query}\"")
         |> assign(results: %{}, query: query)}
    end
  end

  defp search(query) do
    Vickrey.Names.get_name_info(query)
  end
end
