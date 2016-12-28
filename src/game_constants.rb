module GameConstants
  # UI dimensions
  HEIGHT = 400
  WIDTH = 600

  # The number of steps to process every Gosu update
  # The Player ship can get going so fast as to "move through" a
  # star without triggering a collision; an increased number of
  # Chipmunk step calls per update will effectively avoid this issue
  SUBSTEPS = 6

  # FPS
  FPS = 60.0

  # Time increment over which to apply a physics "step" ("delta t")
  DT = 1.0 / FPS
end
