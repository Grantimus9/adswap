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


%Campaign{
  budget: budget,
  name: "Nike Shoe Launch - Awareness",
  description: "You're tasked by Nike to help spread the word that their new basketball shoes, the Slam5 'slams' are now available. This is a branding campaign",
  preferred_times: ["Morning", "NOW"],
  preferred_urls: [
    "www.cnn.com/2018/09/11/us/hurricane-florence-south-east-coast-wxc/index.html",
    "www.xe3f4d94h.com/articles/how-to-generate-revenue-online-working-from-home"
  ],
  preferred_cookie_ids: [
    "cogmint-100",
    "hov10",
    "omega-31"
  ],
  preferred_client_ip_addresses: [
  ]
}
|> Repo.insert!()

%Campaign{
  budget: budget,
  name: "Gold Bar Necklace Sales",
  description: "All the rage are these gold bar necklaces that your client sells. People in Florida can't get enough of them.",
  preferred_times: ["Evening", "Friday Afternoon"],
  preferred_urls: [
    "dougsrecipes.blogspot.com/4/march/2014/recipes-for-pg-j-sandwiches-i-recommend",
    "www.nytimes.com/2018/9/10/climate/methane-emissions-epa.html?action=click",
    "www.nytimes.com/2018/8/13/climate/trump-warming-debate?utm_source=nytimes",
    "www.cnn.com/2018/09/11/us/hurricane-florence-south-east-coast-wxc/index.html",
    "www.moneyversed.com/before-and-after-photos/gallery?id=12"
  ],
  preferred_cookie_ids: [
    "pineapple-3",
    "pinecone-1",
    "everset-200",
    "aviato-3",
    "jetjet-5"
  ],
  preferred_client_ip_addresses: [
    "223.255.255.255",
    "223.255.255.254",
    "223.255.255.250",
    "223.255.255.225"
  ]
}
|> Repo.insert!()

%Campaign{
  budget: budget,
  name: "Moneyversed.com Re-Marketing",
  description: "Moneyversed.com, a site with articles for a general audience, wants to get people that once visited their site to return to their site",
  preferred_times: [],
  preferred_urls: [
    "www.moneyversed.com/before-and-after-photos/gallery?id=12",
    "www.moneyversed.com/before-and-after-photos/gallery?id=12&page=2",
    "www.moneyversed.com/before-and-after-photos/gallery?id=12&page=3",
    "www.moneyversed.com/before-and-after-photos/gallery?id=12&page=4",
    "www.moneyversed.com/before-and-after-photos/gallery?id=12&page=5",
    "www.moneyversed.com/before-and-after-photos/gallery?id=12&page=6",
    "www.moneyversed.com/before-and-after-photos/gallery?id=12&page=7",
    "www.moneyversed.com/before-and-after-photos/gallery?id=12&page=8",
    "www.moneyversed.com/before-and-after-photos/gallery?id=12&page=9",
    "www.moneyversed.com/before-and-after-photos/gallery?id=12&page=10"
  ],
  preferred_cookie_ids: [
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
    "omega-31"
  ],
  preferred_client_ip_addresses: [
  ]
}
|> Repo.insert!()

%Campaign{
  budget: budget,
  name: "Alaska Airlines",
  description: "Alaska Airlines has realized that people that live in Miami are really likely to want to fly to the cold of Alaska. You know any IP that starts with 223 (223.***.***.**) is a Florida IP address.",
  preferred_times: ["Wednesday", "Morning"],
  preferred_urls: [
    "www.bleacherreport.com/articles/2764241",
    "www.nytimes.com/2018/9/10/climate/methane-emissions-epa.html?action=click",
    "www.nytimes.com/2018/8/13/climate/trump-warming-debate?utm_source=nytimes"
  ],
  preferred_cookie_ids: [

  ],
  preferred_client_ip_addresses: [
    "223.255.255.255",
    "223.255.255.254",
    "223.255.255.250",
    "223.255.255.225"
  ]
}
|> Repo.insert!()
