class Beam
  def initialize(start_at_x:, start_at_y: )
    @position_x = start_at_x
    @position_y = start_at_y
  end

  def draw
    Gosu.draw_rect(@position_x, @position_y, 2, 2, Gosu::Color::GREEN)
  end

  def update
    @position_y -= 1
  end

  def in_viewport?
    @position_y > 0
  end
end
