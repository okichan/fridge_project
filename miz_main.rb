require_relative "miz_menu"
require_relative "miz_fridge"
require_relative "miz_ingredient"
require_relative "miz_recipe"
require "colorize"
require 'terminal-table'

# default colors[:black, :light_black, :red, :light_red, :green, :light_green, :yellow, :light_yellow, :blue,
#   :light_blue, :magenta, :light_magenta, :cyan, :light_cyan, :white, :light_white, :default]

 # call methods
new_fridge = Fridge.new("Tomomi")
set_ingredient(new_fridge)
set_recipes(new_fridge)
main_menu(new_fridge)
