class EntityManager
  attr_reader :game_entities

  def initialize(*elements)
    @game_entities = elements
  end

  def add(item)
    game_entities.push(item)
  end

  def find_by_shape(shape)
    @game_entities.find { |item| item.shape == shape }
  end

  def remove(item)
    if game_entities.include?(item)
      Constants::SPACE.remove_body(item.shape.body)
      Constants::SPACE.remove_shape(item.shape)
      @game_entities = game_entities.delete_if { |s| s == item }
    end
  end

  def shapes_in_viewport
    game_entities.select { |item| in_viewport?(item.shape.body.p) }
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
