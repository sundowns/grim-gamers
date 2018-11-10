LargeBlobIce = Class {
    __includes = Enemy,
    init = function(self, worldOrigin)
        Enemy.init(self, "LARGEBLOB-ICE", worldOrigin, constants.ENEMY.LARGEBLOB.HEALTH, constants.ENEMY.LARGEBLOB.SPEED, constants.ENEMY.LARGEBLOB.YIELD, animationController:createInstance("LARGEBLOB-ICE"))
    end;
    update = function(self, dt, currentCell)
        local destroy =  Enemy.update(self, dt, currentCell)
        return destroy
    end;
    draw = function(self)
        Enemy.draw(self)
    end;
    calculateHitbox = function(self)
        return Enemy.calculateHitbox(self)
    end;
}