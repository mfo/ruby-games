# Wraps game loop
class SpaceInvader < Gosu::Window
  MAX_ENEMY = 100

  def initialize
    super(Constants::WIDTH, Constants::HEIGHT)

    self.caption = "SpaceInvader"

    @wait_for = 1_000

    setup_space
    reset_timer
    @font_20 = Gosu::Font.new(20)
    @font_40 = Gosu::Font.new(40)
    @spaceship = Spaceship.new
    @entity_manager = EntityManager.new(@spaceship)
    @collision_manager = CollisionManager.new(@entity_manager)

    @collision_manager.catch_collisions
  end

  def draw
    game_over and return unless @spaceship.life
    background
    @entity_manager.shapes_in_viewport.map(&:draw)
  end

  def update
    return unless @spaceship.life
    pop_enemy if one_sec_elapsed? && !max_entity_reached?
    shoot if Gosu::button_down? Gosu::KbSpace

    Constants::SUBSTEPS.times do
      @collision_manager.handle_collisions
      @entity_manager.shapes_in_viewport.map(&:update)
      Constants::SPACE.step(Constants::DT)
    end

    @entity_manager.clean_outside_viewport
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

  def max_entity_reached?
    @entity_manager.number_of(Enemy) >= MAX_ENEMY
  end

  #
  # Game entities mgmt
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
  def game_over
    Gosu.draw_rect(0, 0, Constants::WIDTH, Constants::HEIGHT, Gosu::Color::WHITE)
    @font_40.draw_rel("GAME OVER", Constants::WIDTH / 2, Constants::HEIGHT / 2, 1, 0.5, 0.5, 1, 1, Gosu::Color::RED)
  end

  def background
    Gosu.draw_rect(0, 0, Constants::WIDTH, Constants::HEIGHT, Gosu::Color::WHITE)
    @font_20.draw_rel("Life: #{@spaceship.life}", 10, 10, 1, 0.0, 0.0, 1, 1, Gosu::Color::BLACK)
    @font_20.draw_rel("Score: #{Constants::SCORE}", Constants::WIDTH - 10, 10, 1, 1.0, 0.0, 1, 1, Gosu::Color::BLACK)
    @font_20.draw_rel("Entities: #{@entity_manager.size}", 10, Constants::HEIGHT - 30, 1, 0.0, 0.0, 1, 1, Gosu::Color::BLACK)
  end
end
