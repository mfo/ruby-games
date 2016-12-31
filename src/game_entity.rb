class GameEntity
  attr_reader :shape

  def self.collision_type
     name.downcase.to_sym
  end

  def initialize(opts = {})
    @shape = CP::Shape::Poly.new(make_body,
                                 make_recentered_poly,
                                 CP::Vec2.new(0,0))
    @shape.collision_type = self.class.collision_type
    add_to_space(@shape)
  end

  def add_to_space(shape)
    Constants::SPACE.add_body(shape.body)
    Constants::SPACE.add_shape(shape)
  end

  def make_body
    CP::Body.new(mass, inertia)
  end

  def make_recentered_poly
    CP::recenter_poly([
      CP::Vec2.new(0, height),
      CP::Vec2.new(width, height),
      CP::Vec2.new(width, 0),
      CP::Vec2.new(0, 0)
    ])
  end

  def draw
    Gosu.draw_rect(@shape.body.p.x,
                   @shape.body.p.y,
                   width,
                   height,
                   color)
  end

end
