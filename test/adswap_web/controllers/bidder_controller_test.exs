defmodule AdswapWeb.BidderControllerTest do
  use AdswapWeb.ConnCase

  alias Adswap.Auction

  @create_attrs %{balance: 42, name: "some name"}
  @update_attrs %{balance: 43, name: "some updated name"}
  @invalid_attrs %{balance: nil, name: nil}

  def fixture(:bidder) do
    {:ok, bidder} = Auction.create_bidder(@create_attrs)
    bidder
  end

  describe "index" do
    test "lists all bidders", %{conn: conn} do
      conn = get conn, bidder_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Bidders"
    end
  end

  describe "new bidder" do
    test "renders form", %{conn: conn} do
      conn = get conn, bidder_path(conn, :new)
      assert html_response(conn, 200) =~ "New Bidder"
    end
  end

  describe "create bidder" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, bidder_path(conn, :create), bidder: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == bidder_path(conn, :show, id)

      conn = get conn, bidder_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Bidder"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, bidder_path(conn, :create), bidder: @invalid_attrs
      assert html_response(conn, 200) =~ "New Bidder"
    end
  end

  describe "edit bidder" do
    setup [:create_bidder]

    test "renders form for editing chosen bidder", %{conn: conn, bidder: bidder} do
      conn = get conn, bidder_path(conn, :edit, bidder)
      assert html_response(conn, 200) =~ "Edit Bidder"
    end
  end

  describe "update bidder" do
    setup [:create_bidder]

    test "redirects when data is valid", %{conn: conn, bidder: bidder} do
      conn = put conn, bidder_path(conn, :update, bidder), bidder: @update_attrs
      assert redirected_to(conn) == bidder_path(conn, :show, bidder)

      conn = get conn, bidder_path(conn, :show, bidder)
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, bidder: bidder} do
      conn = put conn, bidder_path(conn, :update, bidder), bidder: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Bidder"
    end
  end

  describe "delete bidder" do
    setup [:create_bidder]

    test "deletes chosen bidder", %{conn: conn, bidder: bidder} do
      conn = delete conn, bidder_path(conn, :delete, bidder)
      assert redirected_to(conn) == bidder_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, bidder_path(conn, :show, bidder)
      end
    end
  end

  defp create_bidder(_) do
    bidder = fixture(:bidder)
    {:ok, bidder: bidder}
  end
end
