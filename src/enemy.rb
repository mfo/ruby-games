# Enemy to be killed
class Enemy < GameEntity
  def initialize(opts = {})
    super()

    @shape.body.p.x = rand(Constants::WIDTH - 20)
    @shape.body.p.y = 20

    @shape.body.a = (3*Math::PI/2.0) # angle in radians; faces towards top of screen
    @shape.body.apply_force(
      -@shape.body.rot * 30.0,
      CP::Vec2.new(0.0, 0.0)
    )
  end

  #
  # Override GameEntity
  #
  def height
    3
  end

  def width
    10
  end

  def mass
    10.0
  end

  def inertia
    150.0
  end

  def color
    Gosu::Color::RED
  end

  #
  # Gosu API
  #
  def update
  end

  def on_collide(entity_manager, collide_context)
    entity_manager.remove(self)
  end
end


