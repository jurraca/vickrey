defmodule Vickrey.Api.Utils do
    @moduledoc """
        Fetch credentials and format API requests. 
    """
    def headers() do
        auth = ":" <> Application.fetch_env!(:vickrey, :node_api_key) |> Base.encode64()
        [{"Content-Type", "application/json"}, {"Authorization", "Basic " <> auth}]
    end 
    
    def get_node_address() do 
      Application.fetch_env!(:vickrey, :ip) <> ":" <> Application.fetch_env!(:vickrey, :port)
    end 
end 