local ALL_BLUEPRINTS = {
    ["OBSTACLE"] = Blueprint("OBSTACLE", nil, 1, 1),
    ["SAW"] = Blueprint("SAW", assets.blueprints.saw, 2, 2),
    ["CANNON"] = Blueprint("CANNON", assets.blueprints.cannon, 2, 2)
}

PlayerController = Class {
    init = function(self)
        self.money = 1000
        self.blueprints = {
            ALL_BLUEPRINTS["OBSTACLE"]
        }
        table.insert(self.blueprints, ALL_BLUEPRINTS["SAW"]) -- TODO: will be unlocked, not a default value
        table.insert(self.blueprints, ALL_BLUEPRINTS["CANNON"]) -- TODO: will be unlocked, not a default value
        self.currentBlueprint = nil
        self.currentSelectedStructure = nil
    end;
    setCurrentBlueprint = function(self, index)
        if not self.blueprints[index] then return end
        self:toggleStructureSelection()
        
        if inputController.isPlacingTower and self.currentBlueprint then
            if self.currentBlueprint.name == self.blueprints[index].name then
                inputController:togglePlacingTower() --toggle off the current one
                self.currentBlueprint = nil
            elseif self.money >= self.blueprints[index].cost then
                --theyre switching to a different one, check they can afford it
                self.currentBlueprint = self.blueprints[index]
            end
        elseif self.money >= self.blueprints[index].cost then
            self.currentBlueprint = self.blueprints[index]
            inputController:togglePlacingTower()
        end
    end;
    updateMoney = function(self, delta)
        self.money = self.money + delta
    end;
    toggleStructureSelection = function(self, structure)
        if structure == nil then
            if self.currentSelectedStructure then
                self.currentSelectedStructure:toggleSelected()
                self.currentSelectedStructure = nil
            end
            return
        end
        if not self.currentSelectedStructure then
            self.currentSelectedStructure = structure
            self.currentSelectedStructure:toggleSelected()
        else
            if structure.gridOrigin.x == self.currentSelectedStructure.gridOrigin.x
            and structure.gridOrigin.y == self.currentSelectedStructure.gridOrigin.y then
                self.currentSelectedStructure:toggleSelected()
                self.currentSelectedStructure = nil
            else
                self.currentSelectedStructure:toggleSelected()
                self.currentSelectedStructure = structure
                self.currentSelectedStructure:toggleSelected()
            end
        end

    end;
    refundCurrentStructure = function(self)
        if not self.currentSelectedStructure then
            return 
        end
        self:updateMoney(self.currentSelectedStructure.cost)
        world:addFloatingGain("+"..self.currentSelectedStructure.cost, self.currentSelectedStructure.worldOrigin.x + constants.CURRENCY.GAINS.X_OFFSET, self.currentSelectedStructure.worldOrigin.y, true)
        world:removeStructure(self.currentSelectedStructure)
        self:toggleStructureSelection()
    end;
}