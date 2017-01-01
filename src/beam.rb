# Spaceship beam [when user shoot]
class Beam < GameEntity
  def initialize(start_at_x:, start_at_y: )
    super()

    @shape.body.p.x = start_at_x
    @shape.body.p.y = start_at_y

    @shape.body.a = (3*Math::PI/2.0) # angle in radians; faces towards top of screen
    @shape.body.apply_force(
      @shape.body.rot * 1000.0,
      CP::Vec2.new(0.0, 0.0)
    )
  end

  #
  # Override GameEntity
  #
  def mass
    10
  end

  def inertia
    1.0
  end

  def color
    Gosu::Color::GREEN
  end

  #
  # Gosu APIs
  #
  def update
  end

  def on_collide(entity_manager, collide_context)
    case collide_context
    when [:beam, :enemy]
      entity_manager.remove(self)
      Constants::SCORE += 10
    end
  end
end
