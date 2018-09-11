defmodule Adswap.Auction do
  @moduledoc """
  The Auction context.
  """

  import Ecto.Query, warn: false
  alias Adswap.Repo
  alias Adswap.Auction.{Bidder, Campaign}


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
  Returns the list of bidders.

  ## Examples

      iex> list_bidders()
      [%Bidder{}, ...]

  """
  def list_bidders do
    Repo.all(Bidder)
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
    |> Repo.preload(:campaign)
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
