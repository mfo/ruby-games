class Spaceship < GameEntity

  def initialize(opts = {})
    super()

    @shape.body.p.x = (GameConstants::WIDTH / 2) - (width / 2)
    @shape.body.p.y = GameConstants::HEIGHT - 10
  end

  #
  # Override GameEntity
  #
  def height
    2
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
    Gosu::Color::BLACK
  end


  #
  # Gosu APIs
  #
  def update
    @shape.body.reset_forces

    move_left if Gosu::button_down? Gosu::KbLeft
    move_right if Gosu::button_down? Gosu::KbRight
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
