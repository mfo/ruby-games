class SpaceInvader < Gosu::Window
  def initialize
    super(Constants::WIDTH, Constants::HEIGHT)

    self.caption = "SpaceInvader"

    @wait_for = 1_000

    setup_space
    reset_timer
    @spaceship = Spaceship.new
    @entity_manager = EntityManager.new(@spaceship)
    @collision_manager = CollisionManager.new(@entity_manager)

    @collision_manager.catch_collisions
  end

  def draw
    background
    @entity_manager.shapes_in_viewport.map(&:draw)
  end

  def update
    pop_enemy if one_sec_elapsed?
    shoot if Gosu::button_down? Gosu::KbSpace

    Constants::SUBSTEPS.times do
      @entity_manager.shapes_in_viewport.map(&:update)
      Constants::SPACE.step(Constants::DT)
    end

    @entity_manager.clean_outside_viewport
    @collision_manager.handle_collisions
  end

  def button_down(key)
    case key
    when Gosu::KbSpace
      # shoot
    end
  end

  private

  #
  # Game setup
  #
  def setup_space
    Constants::SPACE.damping = 0.8
  end

  #
  # Timer
  #
  def reset_timer
    @last_tick = Gosu.milliseconds
    @wait_for -= 100
  end

  def one_sec_elapsed?
    Gosu.milliseconds - @last_tick > @wait_for
  end

  #
  # Shapes mgmt
  #
  def pop_enemy
    reset_timer
    @entity_manager.add(Enemy.new)
  end

  def shoot
    @entity_manager.add(Beam.new(start_at_x: @spaceship.shape.body.p.x,
                                 start_at_y: @spaceship.shape.body.p.y - 25 ))
  end

  #
  # drawing
  #
  def background
    x = 0
    y = 0

    Gosu.draw_rect(x,
                   y,
                   Constants::WIDTH,
                   Constants::HEIGHT,
                   Gosu::Color::WHITE)
  end
end
