defmodule AdswapWeb.PageController do
  use AdswapWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
