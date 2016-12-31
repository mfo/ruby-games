require 'rubygems'
require 'gosu'
require 'chipmunk'
require 'pry'

require_relative 'src/constants'

# model
require_relative 'src/game_entity'

# game orchestrators
require_relative 'src/entity_manager'
require_relative 'src/collision_manager'

# UI
require_relative 'src/beam'
require_relative 'src/spaceship'
require_relative 'src/enemy'

# Game controller
require_relative 'src/space_invader'

SpaceInvader.new.show
