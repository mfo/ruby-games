module Constants
  #
  # Viewport & rendering
  #
  # UI dimensions
  HEIGHT = 400
  WIDTH = 600

  # FPS
  FPS = 60.0

  #
  # Physics
  #
  # Chipmunk space
  SPACE = CP::Space.new

  # The number of steps to process every Gosu update
  # The spaceship/beams/enemy can get to fast to trigger a collision;
  # increase number of Chipmunk step calls per update avoid this issue
  SUBSTEPS = 6

  # Time increment over which to apply a physics "step" ("delta t")
  DT = 1.0 / FPS
end
