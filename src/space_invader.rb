class SpaceInvader < Gosu::Window
  def initialize
    super(GameConstants::WIDTH, GameConstants::HEIGHT)

    self.caption = "PacMan"

    setup_space
    @wait_for = 1_000
    reset_timer
    make_game_entities
  end

  def draw
    background
    @view_objects.shapes_in_viewport.map(&:draw)
  end

  def update
    pop_enemy if one_sec_elapsed?
    shoot if Gosu::button_down? Gosu::KbSpace
    GameConstants::SUBSTEPS.times do
      @view_objects.shapes_in_viewport.map(&:update)
      GameConstants::SPACE.step(GameConstants::DT)
    end

    @view_objects.clean_outside_viewport
  end

  def button_down(key)
    case key
    when Gosu::KbSpace
      # shoot
    end
  end

  private

  def setup_space
    GameConstants::SPACE.damping = 0.8
  end

  def make_game_entities
    @spaceship = Spaceship.new
    @view_objects = GameEntityManager.new(@spaceship)
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
    @view_objects.add(Enemy.new)
  end

  def shoot
    @view_objects.add(Beam.new(start_at_x: @spaceship.shape.body.p.x,
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
