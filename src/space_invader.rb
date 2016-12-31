class SpaceInvader < Gosu::Window
  def initialize
    super(GameConstants::WIDTH, GameConstants::HEIGHT)

    self.caption = "PacMan"

    setup_space
    reset_timer
    make_game_entities
  end

  def draw
    background
    @spaceship.draw
    @enemies.shapes_in_viewport.map(&:draw)
    @beams.shapes_in_viewport.map(&:draw)
  end

  def update
    pop_enemy if one_sec_elapsed?

    GameConstants::SUBSTEPS.times do
      @spaceship.update

      update_visible_shapes
      GameConstants::SPACE.step(GameConstants::DT)
    end
    remove_shapes_outside_viewport
  end

  def button_down(key)
    case key
    when Gosu::KbSpace
      shoot
    end
  end

  private

  def setup_space
    GameConstants::SPACE.damping = 0.8
  end

  def make_game_entities
    @spaceship = Spaceship.new
    @enemies = Viewportable.new
    @beams = Viewportable.new
  end

  #
  # Timer
  #
  def reset_timer
    @start_time = 0
  end

  def one_sec_elapsed?
    Gosu.milliseconds - @start_time < 10_000
  end

  #
  # Shapes mgmt
  #
  def pop_enemy
    reset_timer
    @enemies.add(Enemy.new)
  end

  def shoot
    @beams.add(Beam.new(start_at_x: @spaceship.shape.body.p.x,
                        start_at_y: @spaceship.shape.body.p.y - 25 ))
  end


  #
  # Remove outside viewport objects
  #
  def update_visible_shapes
    (@beams.shapes_in_viewport + @enemies.shapes_in_viewport)
      .map(&:update)
  end

  def remove_shapes_outside_viewport
    [@beams, @enemies].map(&:clean_outside_viewport)
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
