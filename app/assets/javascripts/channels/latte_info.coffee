App.latte_info = App.cable.subscriptions.create "LatteInfoChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    $('#latte_info').html(data)
