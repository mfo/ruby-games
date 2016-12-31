class CollisionManager
  def initialize(entity_manager)
    @collisions = []
    @entity_manager = entity_manager
  end

  def handle_collisions
    @collisions.map do |shape, collision_context|
      item = @entity_manager.find_by_shape(shape)
      item.on_collide(@entity_manager, collision_context) if item
    end
    @collisions = []
  end

  def catch_collisions
    beam_collide_enemy = [:beam, :enemy]
    enemy_collide_spaceship = [:spaceship, :enemy]

    Constants::SPACE.add_collision_func(*beam_collide_enemy) do |beam_shape, enemy_shape|
      add_collided_shape(beam_shape, beam_collide_enemy)
      add_collided_shape(enemy_shape, beam_collide_enemy)
    end
    Constants::SPACE.add_collision_func(:spaceship, :enemy) do |spaceship_shape, enemy_shape|
      add_collided_shape(enemy_shape, enemy_collide_spaceship)
    end
  end

  private

  def add_collided_shape(shape, collision_context)
    @collisions.push([shape, collision_context])
  end
end

