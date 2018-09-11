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
end
