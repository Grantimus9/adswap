defmodule AdswapWeb.PageView do
  use AdswapWeb, :view


  def click_through_rate(0, _), do: 0
  def click_through_rate(_, 0), do: 0
  def click_through_rate(impressions, clicks) do
    fraction = (clicks / impressions) |> Float.round(3)
    fraction * 100
  end

  # Assuming a start of 1000.
  def cost_per_click(0, _), do: "infinite"
  def cost_per_click(_, 0), do: 0
  def cost_per_click(clicks, budget_remaining) do
    spent = 1000 - budget_remaining
    (spent / clicks)
  end

  def cost_per_milli(0, _), do: "infinite"
  def cost_per_milli(_, 0), do: 0
  def cost_per_milli(imps, budget_remaining) do
    spent = 1000 - budget_remaining
    (spent / imps)
  end

end
