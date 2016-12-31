class SpaceInvader < Gosu::Window
  def initialize
    super(GameConstants::WIDTH, GameConstants::HEIGHT)

    self.caption = "PacMan"

    @wait_for = 1_000

    setup_space
    reset_timer
    make_game_entities
    setup_collisions
  end

  def draw
    background
    @entity_manager.shapes_in_viewport.map(&:draw)
  end

  def update
    pop_enemy if one_sec_elapsed?
    shoot if Gosu::button_down? Gosu::KbSpace
    GameConstants::SUBSTEPS.times do
      @entity_manager.shapes_in_viewport.map(&:update)
      GameConstants::SPACE.step(GameConstants::DT)
    end

    @entity_manager.clean_outside_viewport
    @entity_manager.clean_collided
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
  def setup_collisions
    @remove_shapes = []

    GameConstants::SPACE.add_collision_func(:beam, :enemy) do |beam_shape, enemy_shape|
      @entity_manager.add_collided_shape(beam_shape)
      @entity_manager.add_collided_shape(enemy_shape)
    end
    GameConstants::SPACE.add_collision_func(:spaceship, :enemy) do |spaceship_shape, enemy_shape|
      @entity_manager.add_collided_shape(enemy)
    end
  end

  def setup_space
    GameConstants::SPACE.damping = 0.8
  end

  def make_game_entities
    @spaceship = Spaceship.new
    @entity_manager = GameEntityManager.new(@spaceship)
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
                   GameConstants::WIDTH,
                   GameConstants::HEIGHT,
                   Gosu::Color::WHITE)
  end
end
