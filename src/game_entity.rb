# Simple wrapper to make an UI Object
# must extend : mass, inertia, height, width, color
class GameEntity
  attr_reader :shape

  # collision_type of Enemy == :enemy
  # collision_type of Spaceship == :spaceship
  # collision_type of Beam == :beam
  def self.collision_type
     name.downcase.to_sym
  end

  def initialize(opts = {})
    load_image
    @shape = CP::Shape::Poly.new(make_body,
                                 make_recentered_poly,
                                 CP::Vec2.new(0,0))
    @shape.collision_type = self.class.collision_type
    add_to_space(@shape)
  end

  #
  # Physics
  #
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

  #
  # Graphics
  #
  def image_path
    "graphics/#{self.class.collision_type}.png"
  end

  def load_image
    @image = nil
    @image = Gosu::Image.new(image_path) if File.exists?(image_path)
  end

  def height
    @height ||= @image.height
  end

  def width
    @width ||= @image.width
  end

  #
  # Rendering
  #
  def draw
    if @image
      @image.draw(@shape.body.p.x - (width / 2),
                  @shape.body.p.y - (height / 2),
                  0)
    else
      Gosu.draw_rect(@shape.body.p.x - (width / 2),
                     @shape.body.p.y - (height / 2),
                     width,
                     height,
                     color)
    end
  end

end
