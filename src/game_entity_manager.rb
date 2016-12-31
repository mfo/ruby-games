class GameEntityManager
  attr_reader :collection

  def initialize(*elements)
    @collection = elements
    @collided_shapes = []
  end

  def add(item)
    collection.push(item)
  end

  def add_collided_shape(shape)
    @collided_shapes.push(shape)
  end

  def remove(item)
    if collection.include?(item)
      GameConstants::SPACE.remove_body(item.shape.body)
      GameConstants::SPACE.remove_shape(item.shape)
      @collection = collection.delete_if { |s| s == item }
    end
  end

  def shapes_in_viewport
    collection.select { |item| in_viewport?(item.shape.body.p) }
  end

  def clean_collided
    @collided_shapes.delete_if do |shape|
      item = @collection.find{ |item| item.shape == shape }
      remove(item) if item
    end
    @collided_shapes = []
  end

  def clean_outside_viewport
    collection.select do |item|
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
    (position.x > 0 && position.x < GameConstants::WIDTH) &&
      (position.y > 0 && position.y < GameConstants::HEIGHT)
  end
end
