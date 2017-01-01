# Store all objects to be managed by Chipmunk physics
# Exposing a register/release methods
# Expose some Query methods (in_viewport, outside_viewport, find_by_shape)
# Manage out of viewport objects release
class EntityManager
  attr_reader :game_entities

  def initialize(*elements)
    @game_entities = elements
  end

  #
  # enumerable apis
  #
  def add(item)
    game_entities.push(item)
  end

  def remove(item)
    if game_entities.include?(item)
      Constants::SPACE.remove_body(item.shape.body)
      Constants::SPACE.remove_shape(item.shape)
      @game_entities = game_entities.delete_if { |s| s == item }
    end
  end

  def size
    game_entities.size
  end

  #
  # utilities
  #
  # count number of entity by type
  def number_of(type)
    game_entities.select{|entity| entity.class == type }.size
  end

  #
  # Query methods
  #
  def renderable
    game_entities.select { |item| in_viewport?(item.shape.body.p) }
  end


  # retrieve a game entity given a Chipmunk shape
  def find_by_shape(shape)
    @game_entities.find { |item| item.shape == shape }
  end


  def clean_outside_viewport
    game_entities.select do |item|
      if !in_viewport?(item.shape.body.p)
        remove(item)
        nil
      else
        item
      end
    end
  end

  private


  def in_viewport?(position)
    (position.x > 0 && position.x < Constants::WIDTH) &&
      (position.y > 0 && position.y < Constants::HEIGHT)
  end
end
