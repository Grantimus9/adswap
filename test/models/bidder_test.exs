defmodule Adswap.BidderTest do
  use Adswap.ModelCase

  alias Adswap.Bidder

  @valid_attrs %{balance: 42, name: "some name"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Bidder.changeset(%Bidder{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Bidder.changeset(%Bidder{}, @invalid_attrs)
    refute changeset.valid?
  end
end
