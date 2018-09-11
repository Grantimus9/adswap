defmodule Adswap.AuctionTest do
  use Adswap.DataCase

  alias Adswap.Auction

  describe "bidders" do
    alias Adswap.Auction.Bidder

    @valid_attrs %{balance: 42, name: "some name"}
    @update_attrs %{balance: 43, name: "some updated name"}
    @invalid_attrs %{balance: nil, name: nil}

    def bidder_fixture(attrs \\ %{}) do
      {:ok, bidder} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Auction.create_bidder()

      bidder
    end

    test "list_bidders/0 returns all bidders" do
      bidder = bidder_fixture()
      assert Auction.list_bidders() == [bidder]
    end

    test "get_bidder!/1 returns the bidder with given id" do
      bidder = bidder_fixture()
      assert Auction.get_bidder!(bidder.id) == bidder
    end

    test "create_bidder/1 with valid data creates a bidder" do
      assert {:ok, %Bidder{} = bidder} = Auction.create_bidder(@valid_attrs)
      assert bidder.balance == 42
      assert bidder.name == "some name"
    end

    test "create_bidder/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Auction.create_bidder(@invalid_attrs)
    end

    test "update_bidder/2 with valid data updates the bidder" do
      bidder = bidder_fixture()
      assert {:ok, bidder} = Auction.update_bidder(bidder, @update_attrs)
      assert %Bidder{} = bidder
      assert bidder.balance == 43
      assert bidder.name == "some updated name"
    end

    test "update_bidder/2 with invalid data returns error changeset" do
      bidder = bidder_fixture()
      assert {:error, %Ecto.Changeset{}} = Auction.update_bidder(bidder, @invalid_attrs)
      assert bidder == Auction.get_bidder!(bidder.id)
    end

    test "delete_bidder/1 deletes the bidder" do
      bidder = bidder_fixture()
      assert {:ok, %Bidder{}} = Auction.delete_bidder(bidder)
      assert_raise Ecto.NoResultsError, fn -> Auction.get_bidder!(bidder.id) end
    end

    test "change_bidder/1 returns a bidder changeset" do
      bidder = bidder_fixture()
      assert %Ecto.Changeset{} = Auction.change_bidder(bidder)
    end
  end

  describe "impressions" do
    alias Adswap.Auction.Impression

    @valid_attrs %{client_ip_address: "some client_ip_address", cookie_id: "some cookie_id", time: "some time", url: "some url"}
    @update_attrs %{client_ip_address: "some updated client_ip_address", cookie_id: "some updated cookie_id", time: "some updated time", url: "some updated url"}
    @invalid_attrs %{client_ip_address: nil, cookie_id: nil, time: nil, url: nil}

    def impression_fixture(attrs \\ %{}) do
      {:ok, impression} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Auction.create_impression()

      impression
    end

    test "list_impressions/0 returns all impressions" do
      impression = impression_fixture()
      assert Auction.list_impressions() == [impression]
    end

    test "get_impression!/1 returns the impression with given id" do
      impression = impression_fixture()
      assert Auction.get_impression!(impression.id) == impression
    end

    test "create_impression/1 with valid data creates a impression" do
      assert {:ok, %Impression{} = impression} = Auction.create_impression(@valid_attrs)
      assert impression.client_ip_address == "some client_ip_address"
      assert impression.cookie_id == "some cookie_id"
      assert impression.time == "some time"
      assert impression.url == "some url"
    end

    test "create_impression/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Auction.create_impression(@invalid_attrs)
    end

    test "update_impression/2 with valid data updates the impression" do
      impression = impression_fixture()
      assert {:ok, impression} = Auction.update_impression(impression, @update_attrs)
      assert %Impression{} = impression
      assert impression.client_ip_address == "some updated client_ip_address"
      assert impression.cookie_id == "some updated cookie_id"
      assert impression.time == "some updated time"
      assert impression.url == "some updated url"
    end

    test "update_impression/2 with invalid data returns error changeset" do
      impression = impression_fixture()
      assert {:error, %Ecto.Changeset{}} = Auction.update_impression(impression, @invalid_attrs)
      assert impression == Auction.get_impression!(impression.id)
    end

    test "delete_impression/1 deletes the impression" do
      impression = impression_fixture()
      assert {:ok, %Impression{}} = Auction.delete_impression(impression)
      assert_raise Ecto.NoResultsError, fn -> Auction.get_impression!(impression.id) end
    end

    test "change_impression/1 returns a impression changeset" do
      impression = impression_fixture()
      assert %Ecto.Changeset{} = Auction.change_impression(impression)
    end
  end

  describe "campaigns" do
    alias Adswap.Auction.Campaign

    @valid_attrs %{budget: 42, description: "some description", name: "some name"}
    @update_attrs %{budget: 43, description: "some updated description", name: "some updated name"}
    @invalid_attrs %{budget: nil, description: nil, name: nil}

    def campaign_fixture(attrs \\ %{}) do
      {:ok, campaign} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Auction.create_campaign()

      campaign
    end

    test "list_campaigns/0 returns all campaigns" do
      campaign = campaign_fixture()
      assert Auction.list_campaigns() == [campaign]
    end

    test "get_campaign!/1 returns the campaign with given id" do
      campaign = campaign_fixture()
      assert Auction.get_campaign!(campaign.id) == campaign
    end

    test "create_campaign/1 with valid data creates a campaign" do
      assert {:ok, %Campaign{} = campaign} = Auction.create_campaign(@valid_attrs)
      assert campaign.budget == 42
      assert campaign.description == "some description"
      assert campaign.name == "some name"
    end

    test "create_campaign/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Auction.create_campaign(@invalid_attrs)
    end

    test "update_campaign/2 with valid data updates the campaign" do
      campaign = campaign_fixture()
      assert {:ok, campaign} = Auction.update_campaign(campaign, @update_attrs)
      assert %Campaign{} = campaign
      assert campaign.budget == 43
      assert campaign.description == "some updated description"
      assert campaign.name == "some updated name"
    end

    test "update_campaign/2 with invalid data returns error changeset" do
      campaign = campaign_fixture()
      assert {:error, %Ecto.Changeset{}} = Auction.update_campaign(campaign, @invalid_attrs)
      assert campaign == Auction.get_campaign!(campaign.id)
    end

    test "delete_campaign/1 deletes the campaign" do
      campaign = campaign_fixture()
      assert {:ok, %Campaign{}} = Auction.delete_campaign(campaign)
      assert_raise Ecto.NoResultsError, fn -> Auction.get_campaign!(campaign.id) end
    end

    test "change_campaign/1 returns a campaign changeset" do
      campaign = campaign_fixture()
      assert %Ecto.Changeset{} = Auction.change_campaign(campaign)
    end
  end
end
