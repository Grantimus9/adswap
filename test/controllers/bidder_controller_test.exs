defmodule Adswap.BidderControllerTest do
  use Adswap.ConnCase

  alias Adswap.Bidder
  @valid_attrs %{balance: 42, name: "some name"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, bidder_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing bidders"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, bidder_path(conn, :new)
    assert html_response(conn, 200) =~ "New bidder"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, bidder_path(conn, :create), bidder: @valid_attrs
    bidder = Repo.get_by!(Bidder, @valid_attrs)
    assert redirected_to(conn) == bidder_path(conn, :show, bidder.id)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, bidder_path(conn, :create), bidder: @invalid_attrs
    assert html_response(conn, 200) =~ "New bidder"
  end

  test "shows chosen resource", %{conn: conn} do
    bidder = Repo.insert! %Bidder{}
    conn = get conn, bidder_path(conn, :show, bidder)
    assert html_response(conn, 200) =~ "Show bidder"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, bidder_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    bidder = Repo.insert! %Bidder{}
    conn = get conn, bidder_path(conn, :edit, bidder)
    assert html_response(conn, 200) =~ "Edit bidder"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    bidder = Repo.insert! %Bidder{}
    conn = put conn, bidder_path(conn, :update, bidder), bidder: @valid_attrs
    assert redirected_to(conn) == bidder_path(conn, :show, bidder)
    assert Repo.get_by(Bidder, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    bidder = Repo.insert! %Bidder{}
    conn = put conn, bidder_path(conn, :update, bidder), bidder: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit bidder"
  end

  test "deletes chosen resource", %{conn: conn} do
    bidder = Repo.insert! %Bidder{}
    conn = delete conn, bidder_path(conn, :delete, bidder)
    assert redirected_to(conn) == bidder_path(conn, :index)
    refute Repo.get(Bidder, bidder.id)
  end
end
