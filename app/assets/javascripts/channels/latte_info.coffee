App.latte_info = App.cable.subscriptions.create "LatteInfoChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    $('#latte_spinner').addClass('invi') if data.spin_status == 'inactive'
    $('#latte_spinner').removeClass('invi') if data.spin_status == 'active'
    $('#bar_status').html(data.bar_status) if data.bar_status
    $('#progress').html(data.progress) if data.progress
    $('#latte_info').append(data.latte_info + "<br/><br/>") if data.latte_info
    $(document).scrollTop($(document).height()+1500);
