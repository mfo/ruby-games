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
  def image_path(extension)
    "graphics/#{self.class.collision_type}.#{extension}"
  end

  def load_image
    @image = nil
    existing_file_path = nil

    %w(gif png).map do |extension|
      try_file_path = image_path(extension)
      existing_file_path = try_file_path if File.exists?(try_file_path)
    end
    @image = Gosu::Image.new(existing_file_path) if existing_file_path
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
