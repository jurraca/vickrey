defmodule Vickrey.Analysis do
    @moduledoc """
    With returned data from the DB, create aggregations and calcs.
    """

    alias Vickrey.{Repo, Query}

    # return for a given name
    # highest auctions
    # most txs per name
    #

    def get_3_letter_open_auctions(), do: Query.get_auctions_by_name_and_type("OPEN", 3)

    def get_3_letter_bid_auctions(), do: Query.get_auctions_by_name_and_type("BID", 3)

    @doc """
    Calculates the difference in between the most recent buy and sell of a given name.
    If it hasn't been sold (there is no "TRANSFER", "REGISTER" or "FINALIZE" on the blockchain), then return an error.
    """
    def return_for_name(name) when is_binary(name) do
       txs = name |> Query.get_name_txs()
      case sold?(txs) do
          true -> {:ok, calc_return(txs)}
          false -> {:error, "This name hasn't been sold, so I can't calculate a ROI. "}
      end
    end

    def sold?(txs) do
      Enum.any?(txs, fn %Vickrey.Transaction{action: action} -> action in ["FINALIZE", "TRANSFER"] end )
    end

    def calc_return(txs) do
      txs
      |> Enum.reverse()
      |> Enum.filter(fn %Vickrey.Transaction{action: action} -> action in ["FINALIZE", "TRANSFER"] end )
      # get the sold action and its value
      # get the next register tx and its value
      # compare the two
    end

end
