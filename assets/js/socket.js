// NOTE: The contents of this file will only be executed if
// you uncomment its entry in "assets/js/app.js".

// To use Phoenix channels, the first step is to import Socket
// and connect at the socket path in "lib/web/endpoint.ex":
import {Socket} from "phoenix"

let socket = new Socket("/socket", {params: {token: window.userToken}})

// When you connect, you'll often need to authenticate the client.
// For example, imagine you have an authentication plug, `MyAuth`,
// which authenticates the session and assigns a `:current_user`.
// If the current user exists you can assign the user's token in
// the connection for use in the layout.
//
// In your "lib/web/router.ex":
//
//     pipeline :browser do
//       ...
//       plug MyAuth
//       plug :put_user_token
//     end
//
//     defp put_user_token(conn, _) do
//       if current_user = conn.assigns[:current_user] do
//         token = Phoenix.Token.sign(conn, "user socket", current_user.id)
//         assign(conn, :user_token, token)
//       else
//         conn
//       end
//     end
//
// Now you need to pass this token to JavaScript. You can do so
// inside a script tag in "lib/web/templates/layout/app.html.eex":
//
//     <script>window.userToken = "<%= assigns[:user_token] %>";</script>
//
// You will need to verify the user token in the "connect/2" function
// in "lib/web/channels/user_socket.ex":
//
//     def connect(%{"token" => token}, socket) do
//       # max_age: 1209600 is equivalent to two weeks in seconds
//       case Phoenix.Token.verify(socket, "user socket", token, max_age: 1209600) do
//         {:ok, user_id} ->
//           {:ok, assign(socket, :user, user_id)}
//         {:error, reason} ->
//           :error
//       end
//     end
//
// Finally, pass the token on connect as below. Or remove it
// from connect if you don't care about authentication.

socket.connect()

// Now that you are connected, you can join channels with a topic:
let channel = socket.channel("auction:lobby", {})
let bidInputAmount       = document.querySelector("#bid-input-amount")
let bidInputCode         = document.querySelector("#bid-input-code")
let bidSubmitBtn         = document.querySelector("#submit-bid-btn")
let messagesContainer    = document.querySelector("#messages")
let timeRemainingContainer = document.querySelector("#time-remaining")
let auctionStatusContainer = document.querySelector("#auction-status")
let currentImpressionUrlContainer = document.querySelector("#current-impression-url")
let currentImpressionCookieIdContainer = document.querySelector("#current-impression-cookie-id")
let currentImpressionClientIpAddressContainer = document.querySelector("#current-impression-client-ip-address")
let currentImpressionTimeContainer = document.querySelector("#current-impression-time")



bidInputCode.addEventListener("keypress", event => {
  if(event.keyCode === 13){
    channel.push("new_bid", {bidAmount: bidInputAmount.value, bidCode: bidInputCode.value})
    bidInputAmount.value = null
  }
})

bidInputAmount.addEventListener("keypress", event => {
  if(event.keyCode === 13){
    channel.push("new_bid", {bidAmount: bidInputAmount.value, bidCode: bidInputCode.value})
    bidInputAmount.value = null
  }
})

bidSubmitBtn.addEventListener("click", event => {
  channel.push("new_bid", {bidAmount: bidInputAmount.value, bidCode: bidInputCode.value})
  bidInputAmount.value = null
})

channel.on("new_bid", payload => {
  console.info(payload)
  let messageItem = document.createElement("li")
  messageItem.innerText = `Bid Received`
  messagesContainer.appendChild(messageItem)
})

channel.on("time_remaining", payload => {
  console.info(payload)
  timeRemainingContainer.innerText = payload.time
})

channel.on("auction_status", payload => {
  console.info(payload)
  auctionStatusContainer.innerText = payload.auction_status
})

channel.on("impression", payload => {
  console.info(payload.impression)
  currentImpressionUrlContainer.innerText = payload.impression.url
  currentImpressionCookieIdContainer.innerText = payload.impression.cookie_id
  currentImpressionClientIpAddressContainer.innerText = payload.impression.client_ip_address
  currentImpressionTimeContainer.innerText = payload.impression.time
})

channel.join()
  .receive("ok", resp => { console.log("Joined successfully", resp) })
  .receive("error", resp => { console.log("Unable to join", resp) })

export default socket
