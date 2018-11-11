Round = Class{
    init = function(self, id, enemies)
        self.id = id -- For referencing rounds.lua 
        self.enemies = enemies -- Table consisting of instantiated enemy objects
        self.totalEnemies = #self.enemies
        self.enemiesDefeated = 0
        self.enemiesSpawned = 0
        self.hasStarted = false
    end;
    getNextEnemy = function(self)
        local enemy = self.enemies[self.enemiesSpawned + 1]
        assert(enemy)
        self.enemiesSpawned = self.enemiesSpawned + 1
        return enemy
    end;
    start = function(self)
        self.hasStarted = true
    end;
}