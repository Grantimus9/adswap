# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Adswap.Repo.insert!(%Adswap.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Adswap.Auction.Campaign
alias Adswap.Repo

budget = 1000

%Campaign{
  budget: budget,
  name: "Starbucks New Store Opening",
  description: "Your goal is to let people in Manhattan know that a new store is opening near them!",
  preferred_times: ["Morning"],
  preferred_urls: [
    "www.nytimes.com/2018/09/10/opinion/911-lessons-veteran",
    "www.nytimes.com/2018/9/10/climate/methane-emissions-epa.html?action=click",
    "www.nytimes.com/2018/8/13/climate/trump-warming-debate?utm_source=nytimes"
  ],
  preferred_cookie_ids: [
    "aviato-3",
    "jetjet-5",
    "hhtop-3",
    "iptrace-5",
    "break-23"
  ],
  preferred_client_ip_addresses: [
    "124.164.164.32",
    "124.164.164.31",
    "124.164.164.30",
    "124.164.164.29"
  ]
}
|> Repo.insert!()

# This campaign competes with the Starbucks campaign for URLs, times, and IP addresses,
# but not cookies.
%Campaign{
  budget: budget,
  name: "Peets Coffee Customer Acquisition",
  description: "Word on the street is Starbucks is opening a new store in Manhattan, and you've been charged with trying to get some customers to stopy by your Peet's before they open to try to build some habit and loyalty.",
  preferred_times: ["Morning", "NOW"],
  preferred_urls: [
    "www.nytimes.com/2018/09/10/opinion/911-lessons-veteran",
    "www.nytimes.com/2018/9/10/climate/methane-emissions-epa.html?action=click",
    "www.nytimes.com/2018/8/13/climate/trump-warming-debate?utm_source=nytimes"
  ],
  preferred_cookie_ids: [
    "12345",
    "orange-21",
    "papaya-3",
    "ABC123"
  ],
  preferred_client_ip_addresses: [
    "124.164.164.32",
    "124.164.164.31",
    "124.164.164.30",
    "124.164.164.29"
  ]
}
|> Repo.insert!()
