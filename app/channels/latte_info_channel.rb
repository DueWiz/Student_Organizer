# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class LatteInfoChannel < ApplicationCable::Channel
  def subscribed
    stream_from "latte_info"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
