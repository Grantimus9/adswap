defmodule Adswap.Auction.ImpressionGenerator do
  @moduledoc """
    Generates an impression and saves it.
  """
  alias Adswap.Auction.Impression

  @urls [
    "www.excellentnewsmedia.com/es/sports/la-liga-es-buen",
    "dougsrecipes.blogspot.com/4/march/2014/recipes-for-pg-j-sandwiches-i-recommend",
    "www.xe3f4d94h.com/articles/how-to-generate-revenue-online-working-from-home",
    "www.uber.com/blog/rides-for-everyone",
    "www.nytimes.com/2018/9/10/climate/methane-emissions-epa.html?action=click",
    "www.nytimes.com/2018/8/13/climate/trump-warming-debate?utm_source=nytimes",
    "www.launchdigitalmarketing.com/ad-bidding/glossary#bidder",
    "www.cnn.com/2018/09/11/us/hurricane-florence-south-east-coast-wxc/index.html",
    "www.moneyversed.com/before-and-after-photos/gallery?id=12",
    "www.moneyversed.com/before-and-after-photos/gallery?id=12&page=2",
    "www.moneyversed.com/before-and-after-photos/gallery?id=12&page=3",
    "www.moneyversed.com/before-and-after-photos/gallery?id=12&page=4",
    "www.moneyversed.com/before-and-after-photos/gallery?id=12&page=5",
    "www.moneyversed.com/before-and-after-photos/gallery?id=12&page=6",
    "www.moneyversed.com/before-and-after-photos/gallery?id=12&page=7",
    "www.moneyversed.com/before-and-after-photos/gallery?id=12&page=8",
    "www.moneyversed.com/before-and-after-photos/gallery?id=12&page=9",
    "www.moneyversed.com/before-and-after-photos/gallery?id=12&page=10",
    "www.bleacherreport.com/articles/2764241",
    "www.nytimes.com/2018/09/10/opinion/911-lessons-veteran",
    "null",
    "null",
    "null"
  ]

  @times [
    "Morning",
    "Afternoon",
    "Evening",
    "Weekend",
    "Monday Morning",
    "Friday Afernoon",
    "Saturday",
    "Wednesday",
    "NOW",
    "NOW",
    "NOW"
  ]

  @cookie_ids [
    "null",
    "-1",
    "12345",
    "orange-21",
    "papaya-3",
    "ABC123",
    "pineapple-3",
    "pinecone-1",
    "everset-200",
    "aviato-3",
    "jetjet-5",
    "hhtop-3",
    "iptrace-5",
    "break-23",
    "lubsuge-40",
    "cogmint-100",
    "hov10",
    "omega-31",
    "null"
  ]

  @ipaddresses [
    "127.0.0.1",
    "55.600.12.1",
    "191.255.255.255",
    "127.255.255.255",
    "223.255.255.255",
    "223.255.255.254",
    "223.255.255.250",
    "223.255.255.225",
    "0.0.0.1",
    "1.1.1.1",
    "124.164.164.32",
    "124.164.164.31",
    "124.164.164.30",
    "124.164.164.29",
    "null",
    "null",
    "null"
  ]

  def generate!(count \\ 10) do
    1..count
    |> Enum.each(fn(int) ->
      %Impression{
        client_ip_address: Enum.random(@ipaddresses),
        cookie_id: Enum.random(@cookie_ids),
        time: Enum.random(@times),
        url: Enum.random(@urls)
      }
      |> Adswap.Repo.insert!()
    end)
  end

  def generate(count \\ 10) do
    1..count
    |> Enum.map(fn(int) ->
      %Impression{
        client_ip_address: Enum.random(@ipaddresses),
        cookie_id: Enum.random(@cookie_ids),
        time: Enum.random(@times),
        url: Enum.random(@urls)
      }
    end)
  end

end
