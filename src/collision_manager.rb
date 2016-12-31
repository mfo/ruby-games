# Registers Chipmunk collision functions based on objects collision_type
# Expose handle_collisions to process them in game loop
# Delegate collision management to objects.on_collide(object, collision context)
class CollisionManager
  def initialize(entity_manager)
    @collisions = []
    @entity_manager = entity_manager
  end

  # process collision in batch ? not sure good approach
  def handle_collisions
    @collisions.map do |shape, collision_context|
      game_entity = @entity_manager.find_by_shape(shape)
      game_entity.on_collide(@entity_manager, collision_context) if game_entity
    end
    @collisions = []
  end

  # collects collisions (to be handled later)
  def catch_collisions
    beam_collide_enemy = [:beam, :enemy]
    enemy_collide_spaceship = [:spaceship, :enemy]

    Constants::SPACE.add_collision_func(*beam_collide_enemy) do |beam_shape, enemy_shape|
      add_collided_shape(beam_shape, beam_collide_enemy)
      add_collided_shape(enemy_shape, beam_collide_enemy)
    end
    Constants::SPACE.add_collision_func(*enemy_collide_spaceship) do |spaceship_shape, enemy_shape|
      add_collided_shape(enemy_shape, enemy_collide_spaceship)
      add_collided_shape(spaceship_shape, enemy_collide_spaceship)
    end
  end

  private

  # stores shapes [Beam<->Enemy] colliding in a context [:beam collides :enemy]
  def add_collided_shape(shape, collision_context)
    @collisions.push([shape, collision_context])
  end
end

