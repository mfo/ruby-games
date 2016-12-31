require 'rubygems'
require 'gosu'
require 'chipmunk'

require 'pry'

require_relative 'src/game_entity_manager'
require_relative 'src/game_constants'
require_relative 'src/beam'
require_relative 'src/spaceship'
require_relative 'src/enemy'
require_relative 'src/space_invader'

SpaceInvader.new.show
