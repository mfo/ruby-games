class Enemy
  HEIGHT = 3
  WIDTH = 10
  MASS = 10.0
  INERTIA = 150.0

  attr_reader :shape

  def initialize
    body = CP::Body.new(MASS, INERTIA)
    shape_array = [ CP::Vec2.new(-10, -10),
                    CP::Vec2.new(-10, 10),
                    CP::Vec2.new(10, 1.0),
                    CP::Vec2.new(10, -1.0) ]
    @shape = CP::Shape::Poly.new(body, shape_array, CP::Vec2.new(0,0))
    @shape.collision_type = :ship
    @shape.body.p.x = rand(GameConstants::WIDTH - 20)
    @shape.body.p.y = 20

    @shape.body.a = (3*Math::PI/2.0) # angle in radians; faces towards top of screen

    GameConstants::SPACE.add_body(body)
    GameConstants::SPACE.add_shape(@shape)

    @shape.body.apply_force(
      -@shape.body.rot * 10.0,
      CP::Vec2.new(0.0, 0.0)
    )
  end

  def draw
    Gosu.draw_rect(@shape.body.p.x, @shape.body.p.y, WIDTH, HEIGHT, Gosu::Color::RED)
  end

  def update
  end
end


