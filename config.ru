# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment', __FILE__)
require './middleware/action_cable_latte.rb'
# Action Cable requires that all classes are loaded in advance
Rails.application.eager_load!

use LatteActionCable
run Rails.application
