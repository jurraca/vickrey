# Vickrey

Vickrey is an interface for your Handshake node written in Elixir. 

It can do a few things: 
- Interface with your node by implementing the RPC and API methods available.
- Let you search for names via a UI.
- See chain activity--bids, opens, reveals--as they come in to your node in a friendly LiveView-powered interface. [*WIP*]
- Set a watchlist to monitor names. [*TODO*]
- Set alerts for certain names (upon release, a day before the last bid, etc). [*TODO*] 

You'll need Elixir (and therefore Erlang/OTP) installed. 
  * set up the environment variables for your node in `config/config.exs` 
  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * `cd assets` and `npm install`
  * Start Phoenix endpoint with `mix phx.server` or `iex -S mix phx.server` if you want the cli as well. 

The app runs on [`localhost:4000`](http://localhost:4000) which you can access from your browser.

