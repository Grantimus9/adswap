defmodule AdswapWeb.ImpressionControllerTest do
  use AdswapWeb.ConnCase

  alias Adswap.Auction

  @create_attrs %{client_ip_address: "some client_ip_address", cookie_id: "some cookie_id", time: "some time", url: "some url"}
  @update_attrs %{client_ip_address: "some updated client_ip_address", cookie_id: "some updated cookie_id", time: "some updated time", url: "some updated url"}
  @invalid_attrs %{client_ip_address: nil, cookie_id: nil, time: nil, url: nil}

  def fixture(:impression) do
    {:ok, impression} = Auction.create_impression(@create_attrs)
    impression
  end

  describe "index" do
    test "lists all impressions", %{conn: conn} do
      conn = get conn, impression_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Impressions"
    end
  end

  describe "new impression" do
    test "renders form", %{conn: conn} do
      conn = get conn, impression_path(conn, :new)
      assert html_response(conn, 200) =~ "New Impression"
    end
  end

  describe "create impression" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, impression_path(conn, :create), impression: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == impression_path(conn, :show, id)

      conn = get conn, impression_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Impression"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, impression_path(conn, :create), impression: @invalid_attrs
      assert html_response(conn, 200) =~ "New Impression"
    end
  end

  describe "edit impression" do
    setup [:create_impression]

    test "renders form for editing chosen impression", %{conn: conn, impression: impression} do
      conn = get conn, impression_path(conn, :edit, impression)
      assert html_response(conn, 200) =~ "Edit Impression"
    end
  end

  describe "update impression" do
    setup [:create_impression]

    test "redirects when data is valid", %{conn: conn, impression: impression} do
      conn = put conn, impression_path(conn, :update, impression), impression: @update_attrs
      assert redirected_to(conn) == impression_path(conn, :show, impression)

      conn = get conn, impression_path(conn, :show, impression)
      assert html_response(conn, 200) =~ "some updated client_ip_address"
    end

    test "renders errors when data is invalid", %{conn: conn, impression: impression} do
      conn = put conn, impression_path(conn, :update, impression), impression: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Impression"
    end
  end

  describe "delete impression" do
    setup [:create_impression]

    test "deletes chosen impression", %{conn: conn, impression: impression} do
      conn = delete conn, impression_path(conn, :delete, impression)
      assert redirected_to(conn) == impression_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, impression_path(conn, :show, impression)
      end
    end
  end

  defp create_impression(_) do
    impression = fixture(:impression)
    {:ok, impression: impression}
  end
end
