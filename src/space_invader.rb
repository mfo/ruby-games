class SpaceInvader < Gosu::Window
  def initialize
    super(GameConstants::WIDTH, GameConstants::HEIGHT)

    self.caption = "PacMan"
    @spaceship = Spaceship.new
    @enemies = [Enemy.new]
  end

  def draw
    background
    @spaceship.draw
    @enemies.map(&:draw)
  end

  def update
    @spaceship.update
    @enemies.map(&:update)
  end

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
