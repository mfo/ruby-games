class Beam
  WIDTH = 2
  HEIGHT = 3
  MASS = 10
  INERTIA = 1.0

  attr_reader :shape

  def initialize(start_at_x:, start_at_y: )
    body = CP::Body.new(MASS, INERTIA)
    shape_array = [ CP::Vec2.new(-0.1, -0.1),
                    CP::Vec2.new(-0.1, 0.1),
                    CP::Vec2.new(0.1, 1.0),
                    CP::Vec2.new(0.1, -1.0) ]
    @shape = CP::Shape::Poly.new(body, shape_array, CP::Vec2.new(0,0))
    @shape.collision_type = :ship
    @shape.body.p.x = start_at_x
    @shape.body.p.y = start_at_y
    @shape.body.a = (3*Math::PI/2.0) # angle in radians; faces towards top of screen

    GameConstants::SPACE.add_body(body)
    GameConstants::SPACE.add_shape(@shape)

    @shape.body.apply_force(
      @shape.body.rot * 1000.0,
      CP::Vec2.new(0.0, 0.0)
    )
  end

  #
  # gosu api
  #
  def draw
    Gosu.draw_rect(@shape.body.p.x, @shape.body.p.y, WIDTH, HEIGHT, Gosu::Color::GREEN)
  end

  def update
  end

  #
  # helpers
  #
  def in_viewport?
    @shape.body.p.y > 0
  end
end
