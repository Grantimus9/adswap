defmodule Adswap.Auction do
  @moduledoc """
  The Auction context.
  """

  import Ecto.Query, warn: false
  alias Adswap.Repo
  alias Adswap.Auction.{Bidder, Campaign, Impression, ImpressionGenerator}


  @doc """
    Assigns a campaign to a bidder.
  """
  def assign_campaign(bidder = %Bidder{}) do
    bidder = bidder |> Repo.preload(:campaign)
    case bidder.campaign do
      nil ->
        campaign =
          Campaign
          |> Repo.all()
          |> Enum.random()

        update_bidder(bidder, %{campaign_id: campaign.id})

      campaign ->
        {:ok, bidder}
    end
  end

  def assign_all_campaigns() do
    Bidder
    |> Repo.all()
    |> Enum.map(&assign_campaign/1)
  end


  @doc """
    Returns the winning bid.
  """
  def rank_bids(bids) do
    bids
    |> Enum.sort(&(Map.get(&1, :bid_amount) >= Map.get(&2, :bid_amount)))
  end

  def choose_winner(bids) when length(bids) == 0 do
    %{
      winner_code: "No One.",
      winner_bid: 0,
      winner_pays: 0
    }
  end
  def choose_winner(bids) when length(bids) == 1 do
    [winner | losers] = rank_bids(bids)
    payment_amount = Map.get(winner, :bid_amount)
    %{
      winner_code: Map.get(winner, :bidder_code),
      winner_bid: Map.get(winner, :bid_amount),
      winner_pays: payment_amount
    }
  end
  def choose_winner(bids) when length(bids) > 1 do
    [winner | losers] = rank_bids(bids)
    [second_place | _losers] = losers
    payment_amount = Map.get(second_place, :bid_amount) + 1

    %{
      winner_code: Map.get(winner, :bidder_code),
      winner_bid: Map.get(winner, :bid_amount),
      winner_pays: payment_amount
    }
  end

  @doc """
    Deduct balance from winner.
  """
  def bill_winning_campaign(%{winner_code: code, winner_pays: amount}) do
    bidder = Repo.get_by(Bidder, code: code) |> Repo.preload(:campaign)

    case bidder do
      nil ->
        {:error, "No Such Bidder by Code"}
      bidder ->
        campaign = bidder |> Map.get(:campaign)
        budget = campaign |> Map.get(:budget)
        new_budget = budget - amount
        update_campaign(campaign, %{budget: new_budget})
    end
  end

  def settle_auction(impression_map, %{winner_code: code, winner_pays: amount}) do
    case bill_winning_campaign(%{winner_code: code, winner_pays: amount}) do
      {:ok, campaign} ->
        log_impression(impression_map, %{winner_code: code, winner_pays: amount})

      _ ->
        nil
    end
  end

  # Create bids.
  def persist_bids_to_db(bids) do

  end

  #
  def log_impression(nil, _), do: {:error, "No impression map supplied"}
  def log_impression(_, nil), do: {:error, "No Winning Bid Provided"}
  def log_impression(impression_map, %{bidder_code: code}) do
    {:ok, impression} = create_impression(impression_map)

    campaign =
      Bidder
      |> Repo.get_by(code: code)
      |> Repo.preload(:campaign)
      |> Map.get(:campaign)

    impression
    |> update_impression(%{
      clicked: clicked?(campaign, impression),
      campaign: campaign
      })
  end

  @doc """
    Chooses if the winning bid/campaign got a click from the given impression.
  """
  def clicked?(campaign = %Campaign{}, impression = %Impression{}) do
    targets_hit =
      [
        preferred_client_ip_address?(campaign, impression),
        preferred_cookie_id?(campaign, impression),
        preferred_url?(campaign, impression),
        preferred_time?(campaign, impression)
      ]
      |> Enum.filter(&(&1 == true))
      |> Enum.count()

    case targets_hit do
      0 ->
        # 1/5 chance.
        probability_to_boolean(10, 100)

      1 ->
        # 1/4 chance of click
        probability_to_boolean(25, 100)

      2 ->
        # 50/50 chance of click
        probability_to_boolean(50, 100)

      3 ->
        # 75% chance
        probability_to_boolean(75, 100)

      4 ->
        # 95% chance
        probability_to_boolean(95, 100)

      _ ->
        # something went wrong, 5% chance.
        probability_to_boolean(5, 100)
    end
  end

  # Given a probability expressed as chance/divisor,
  # returns t/f by randomly pulling a result.
  # e.g. probability_to_boolean(6, 10) means 60% chance.
  defp probability_to_boolean(chance, divisor) when is_integer(chance) and is_integer(divisor) do
    if :rand.uniform(divisor) <= chance do
      true
    else
      false
    end
  end

  defp preferred_client_ip_address?(campaign = %Campaign{}, impression = %Impression{}) do
    impression.client_ip_address in campaign.preferred_client_ip_addresses
  end

  defp preferred_cookie_id?(campaign = %Campaign{}, impression = %Impression{}) do
    impression.cookie_id in campaign.preferred_cookie_ids
  end

  defp preferred_url?(campaign = %Campaign{}, impression = %Impression{}) do
    impression.url in campaign.preferred_urls
  end

  defp preferred_time?(campaign = %Campaign{}, impression = %Impression{}) do
    impression.time in campaign.preferred_times
  end


  @doc """
  Returns the list of bidders.

  ## Examples

      iex> list_bidders()
      [%Bidder{}, ...]

  """
  def list_bidders do
    Bidder
    |> Repo.all()
    |> Repo.preload([campaign: [:impressions]])
  end

  @doc """
  Gets a single bidder.

  Raises `Ecto.NoResultsError` if the Bidder does not exist.

  ## Examples

      iex> get_bidder!(123)
      %Bidder{}

      iex> get_bidder!(456)
      ** (Ecto.NoResultsError)

  """
  def get_bidder!(id) do
    Bidder
    |> Repo.get!(id)
    |> Repo.preload([campaign: [:impressions]])
  end

  @doc """
  Creates a bidder.

  ## Examples

      iex> create_bidder(%{field: value})
      {:ok, %Bidder{}}

      iex> create_bidder(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_bidder(attrs \\ %{}) do
    chgset = %Bidder{} |> Bidder.changeset(attrs)
    case Repo.insert(chgset) do
      {:ok, bidder} ->
        assign_campaign(bidder)
      errors ->
        errors
    end
  end

  @doc """
  Updates a bidder.

  ## Examples

      iex> update_bidder(bidder, %{field: new_value})
      {:ok, %Bidder{}}

      iex> update_bidder(bidder, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_bidder(%Bidder{} = bidder, attrs) do
    bidder
    |> Bidder.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Bidder.

  ## Examples

      iex> delete_bidder(bidder)
      {:ok, %Bidder{}}

      iex> delete_bidder(bidder)
      {:error, %Ecto.Changeset{}}

  """
  def delete_bidder(%Bidder{} = bidder) do
    Repo.delete(bidder)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking bidder changes.

  ## Examples

      iex> change_bidder(bidder)
      %Ecto.Changeset{source: %Bidder{}}

  """
  def change_bidder(%Bidder{} = bidder) do
    Bidder.changeset(bidder, %{})
  end

  alias Adswap.Auction.Impression

  @doc """
  Returns the list of impressions.

  ## Examples

      iex> list_impressions()
      [%Impression{}, ...]

  """
  def list_impressions do
    Repo.all(Impression)
  end

  @doc """
  Gets a single impression.

  Raises `Ecto.NoResultsError` if the Impression does not exist.

  ## Examples

      iex> get_impression!(123)
      %Impression{}

      iex> get_impression!(456)
      ** (Ecto.NoResultsError)

  """
  def get_impression!(id), do: Repo.get!(Impression, id)

  @doc """
  Creates a impression.

  ## Examples

      iex> create_impression(%{field: value})
      {:ok, %Impression{}}

      iex> create_impression(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_impression(attrs \\ %{}) do
    %Impression{}
    |> Impression.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a impression.

  ## Examples

      iex> update_impression(impression, %{field: new_value})
      {:ok, %Impression{}}

      iex> update_impression(impression, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_impression(%Impression{} = impression, attrs) do
    impression
    |> Impression.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Impression.

  ## Examples

      iex> delete_impression(impression)
      {:ok, %Impression{}}

      iex> delete_impression(impression)
      {:error, %Ecto.Changeset{}}

  """
  def delete_impression(%Impression{} = impression) do
    Repo.delete(impression)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking impression changes.

  ## Examples

      iex> change_impression(impression)
      %Ecto.Changeset{source: %Impression{}}

  """
  def change_impression(%Impression{} = impression) do
    Impression.changeset(impression, %{})
  end

  alias Adswap.Auction.Campaign

  @doc """
  Returns the list of campaigns.

  ## Examples

      iex> list_campaigns()
      [%Campaign{}, ...]

  """
  def list_campaigns do
    Repo.all(Campaign)
  end

  @doc """
  Gets a single campaign.

  Raises `Ecto.NoResultsError` if the Campaign does not exist.

  ## Examples

      iex> get_campaign!(123)
      %Campaign{}

      iex> get_campaign!(456)
      ** (Ecto.NoResultsError)

  """
  def get_campaign!(id), do: Repo.get!(Campaign, id)

  @doc """
  Creates a campaign.

  ## Examples

      iex> create_campaign(%{field: value})
      {:ok, %Campaign{}}

      iex> create_campaign(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_campaign(attrs \\ %{}) do
    %Campaign{}
    |> Campaign.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a campaign.

  ## Examples

      iex> update_campaign(campaign, %{field: new_value})
      {:ok, %Campaign{}}

      iex> update_campaign(campaign, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_campaign(%Campaign{} = campaign, attrs) do
    campaign
    |> Campaign.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Campaign.

  ## Examples

      iex> delete_campaign(campaign)
      {:ok, %Campaign{}}

      iex> delete_campaign(campaign)
      {:error, %Ecto.Changeset{}}

  """
  def delete_campaign(%Campaign{} = campaign) do
    Repo.delete(campaign)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking campaign changes.

  ## Examples

      iex> change_campaign(campaign)
      %Ecto.Changeset{source: %Campaign{}}

  """
  def change_campaign(%Campaign{} = campaign) do
    Campaign.changeset(campaign, %{})
  end
end
