class Enemy
  WIDTH = 10

  def initialize
    @x = rand(WIDTH)
    @y = 10
  end

  def update
    @y += 1
  end

  def draw
    Gosu.draw_rect(@x, @y, WIDTH, 2, Gosu::Color::RED)
  end
end


