return {
    CAMERA_SPEED = 300,
    COLOURS = {
        DEBUG_PRINT = {0,1,0},
        EMPTY = {0,0,0},
        HOVERED = {0,1,0},
        OBSTACLE = {1,1,1},
        GOAL = {1,1,0},
        SPAWN_ACTIVE = {0,0,1},
        SPAWN_INACTIVE = {1,0,0},
        TOWER = {0,0,1},
        ENEMY = {1,0,0}
    },
    GRID = {
        COLUMNS = 32,
        ROWS = 32,
        CELL_SIZE = 16,
    },
    TOWER = {
        SAW = {
            WIDTH = 2, --cells
            HEIGHT = 2, --cells
            ATTACK_DAMAGE = 5, --damage per second 
            ATTACK_RADIUS = 1 --additional cell radii
        }
    },
    ENEMY = {
        RADIUS = 4,
        SPAWN_INTERVAL = 1,
        SMALLGUY = {
            HEALTH = 10,
            SPEED = 10
        }
    }
}