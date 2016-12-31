class Spaceship
  HEIGHT = 2
  WIDTH = 10

  MASS = 10.0
  INERTIA = 150.0

  attr_reader :shape

  def initialize
    body = CP::Body.new(MASS, INERTIA)
    shape_array = [ CP::Vec2.new(0, 25.0),
                    CP::Vec2.new(25.0, 25.0),
                    CP::Vec2.new(25.0, 0),
                    CP::Vec2.new(0, 0) ]
    @shape = CP::Shape::Poly.new(body, CP::recenter_poly(shape_array), CP::Vec2.new(0,0))
    @shape.collision_type = :ship

    @shape.body.p.x = (GameConstants::WIDTH / 2) - (WIDTH / 2)
    @shape.body.p.y = GameConstants::HEIGHT - 10

    GameConstants::SPACE.add_body(body)
    GameConstants::SPACE.add_shape(@shape)
  end

  #
  # Gosu APIs
  #
  def update
    @shape.body.reset_forces

    move_left if Gosu::button_down? Gosu::KbLeft
    move_right if Gosu::button_down? Gosu::KbRight
  end

  def draw
    Gosu.draw_rect(@shape.body.p.x, @shape.body.p.y, WIDTH, HEIGHT, Gosu::Color::BLACK)
  end

  private

  #
  # move body in physics space
  #
  def move_left
    @shape.body.apply_force(
      -(@shape.body.rot * 150.0) * 0.5,
      CP::Vec2.new(0.0, 0.0)
    )
  end

  def move_right
    @shape.body.apply_force(
      (@shape.body.rot * 150.0) * 0.5,
      CP::Vec2.new(0.0, 0.0)
    )
  end
end
