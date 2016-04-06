# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
module ApplicationCable
    class Connection < ActionCable::Connection::Base

  protected
    def find_verified_user
        verified_user = User.find_by(id: cookies.signed['user.id'])
        if verified_user && cookies.signed['user.expires_at'] > Time.now
            verified_user
        else
            reject_unauthorized_connection
        end
    end
    end
end
