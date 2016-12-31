# The game hero
class Spaceship < GameEntity
  attr_reader :life

  def initialize(opts = {})
    super()
    @life = true

    @shape.body.p.x = (Constants::WIDTH / 2) - (width / 2)
    @shape.body.p.y = Constants::HEIGHT - height - 10
  end

  #
  # Override GameEntity
  #
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

  def on_collide(entity_manager, collide_context)
    case collide_context
    when [:spaceship, :enemy]
      @life = !@life
    end
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
