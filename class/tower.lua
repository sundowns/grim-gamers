Tower = Class {
    __includes=Structure,
    init = function(self, animation, gridOrigin, worldOrigin, width, height)
        Structure.init(self, animation, gridOrigin, worldOrigin, width, height)
        self.type = "TOWER" -- used to check for valid collisions
        self.mutation = nil
    end;
    addMutation = function(self, mutation, animation)
        if not self.mutation then
            self.mutation = mutation
            self.animation = animation
            self:changeAnimationState("DEFAULT")
        end
    end;
    update = function(self, dt)
        Structure.update(self, dt)
    end;
    draw = function(self)
        Structure.draw(self)
    end;
    calculateHitbox = function(self)
        -- calculate a rectangle for the hitbox, where x, y are the origin (top-left).
        local x = self.worldOrigin.x - self.targettingRadius * constants.GRID.CELL_SIZE
        local y = self.worldOrigin.y - self.targettingRadius * constants.GRID.CELL_SIZE
        local width = (self.width + 2*(self.targettingRadius)) *constants.GRID.CELL_SIZE
        local height = (self.height + 2*(self.targettingRadius)) *constants.GRID.CELL_SIZE
        return x, y, width, height
    end;
}

MeleeTower = Class {
    __includes = Tower,
    init = function(self, animation, gridOrigin, worldOrigin, width, height)
        Tower.init(self, animation, gridOrigin, worldOrigin, width, height)
        self.archetype = "MELEE"
    end;
    update = function(self, dt)
        Tower.update(self, dt)
    end;
    addMutation = function(self, mutation, animation)
        Tower.addMutation(self, mutation, animation)
    end;
}

TargetedTower = Class {
    __includes = Tower,
    init = function(self, animation, gridOrigin, worldOrigin, width, height)
        Tower.init(self, animation, gridOrigin, worldOrigin, width, height)
        self.archetype = "TARGETTED"
        self.currentTarget = nil
        self.angleToTarget = 0
        self.projectiles = {}
    end;
    spottedEnemy = function(self, enemy)
        if not self.currentTarget then
            self.currentTarget = enemy
        end
    end;
    update = function(self, dt)
        Tower.update(self, dt)

        if self.currentTarget and (not self:inRange(self.currentTarget) or self.currentTarget.markedForDeath)  then 
            self.currentTarget = nil
        end

        if self.currentTarget then
            local cX, cY = self:centre()
            local dy = cY - self.currentTarget.worldOrigin.y  
            local dx = self.currentTarget.worldOrigin.x - cX
            self.angleToTarget = math.atan2(dx, dy)
        end

        for i = #self.projectiles, 1, -1 do
            self.projectiles[i]:update(dt)
            if self.projectiles[i].markedForDeath then
                table.remove(self.projectiles, i)
            end
        end
    end;
    draw = function(self)
        Tower.draw(self)

        for i, projectile in pairs(self.projectiles) do
            projectile:draw()
        end
    end;
    addMutation = function(self, mutation, animation)
        Tower.addMutation(self, mutation, animation)
    end;
    inRange = function(self, enemy)
        assert(enemy and enemy.worldOrigin)
        local x, y, width, height = Tower.calculateHitbox(self)
        return enemy.worldOrigin.x > x and 
            enemy.worldOrigin.x < x + width and
            enemy.worldOrigin.y > y and
            enemy.worldOrigin.y < y + height
    end;
}