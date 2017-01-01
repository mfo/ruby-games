class Explosion < GameEntity
  def mass
    0.1
  end

  def inertia
    0.1
  end

  def initialize(enemy: , entity_manager:)
    super()
    @entity_manager = entity_manager
    # Reuse enemy collided
    @shape.body.p.x = enemy.shape.body.p.x
    @shape.body.p.y = enemy.shape.body.p.y
    @shape.body.a = enemy.shape.body.a
    @shape.body.v = enemy.shape.body.v

    @animation = Gosu::Image.load_tiles("graphics/explosion.png", 36, 31)
    @frame = 0
  end

  def draw
    img = @animation[@frame]
    img.draw(@shape.body.p.x - img.width / 2.0,
             @shape.body.p.y - img.height / 2.0,
             0)
    @frame += 1
    @entity_manager.remove(self) if @frame >= @animation.size
  end

  def on_collide
  end

  def update
  end
end
