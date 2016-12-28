class Spaceship
  WIDTH = 10

  def initialize
    @x = (GameConstants::WIDTH / 2) - WIDTH
    @y = (GameConstants::HEIGHT - 10)
    @beams = []
  end

  def listen
    move_left if Gosu::button_down? Gosu::KbLeft
    move_right if Gosu::button_down? Gosu::KbRight
    shoot if Gosu::button_down? Gosu::KbSpace
  end

  # Gosu APIs
  def update
    listen

    # cleanup outdated beams
    @beams = @beams.select do | beam |
      if beam.in_viewport?
        beam
      end
    end

    # update for render
    @beams.map(&:update)
  end

  def draw
    Gosu.draw_rect(@x, @y, WIDTH, 2, Gosu::Color::BLACK)
    @beams.map(&:draw)
  end

  private

  def move_left
    @x -= 2
  end

  def move_right
    @x += 2
  end

  def shoot
    @beams.push(Beam.new(start_at_x: @x + WIDTH / 2,
                         start_at_y: @y))
  end

end
