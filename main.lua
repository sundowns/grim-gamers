love.filesystem.setRequirePath(love.filesystem.getRequirePath()..";lib/?.lua;lib/;")

-- Globals (yikes)
debug = false
cameraController = {}
inputController = {}
world = {}

function love.load()
    assets = require('lib.cargo').init('asset')
    Class = require("lib.class")
    Vector = require("lib.vector")
    Timer = require("lib.timer")
    Util = require("lib.util")
    constants = require("constants")
    bump = require("lib.bump")
    anim8 = require("lib.anim8")
    require("controller.camera")
    require("controller.input")
    require("class.cell")
    require("class.grid")
    require("class.projectile")
    require("class.structure")
    require("class.tower")
    require("class.enemy")
    require("class.round")
    require("class.world")
    require("structure.obstacle")
    require("structure.spudgun") 
    require("structure.saw") 
    require("enemy.smallguy")
    require("enemy.largeguy")
    
    love.graphics.setDefaultFilter('nearest')
    world = World(Vector(0,0), constants.GRID.ROWS, constants.GRID.COLUMNS, require("rounds"), 0)
    inputController = InputController()
    cameraController = CameraController(Vector(world.origin.x + constants.GRID.ROWS/2*constants.GRID.CELL_SIZE, world.origin.y + constants.GRID.COLUMNS/2*constants.GRID.CELL_SIZE))
end

function love.update(dt)
    world:update(dt)

    inputController:update(dt)
    cameraController:update(dt)
end

function love.draw()
    cameraController:attach()
        world:draw()
    cameraController:detach()
    love.graphics.setColor(constants.COLOURS.DEBUG_PRINT)
    love.graphics.print("CURRENT MARKET VALUE: " .. world.money, love.graphics.getWidth() - love.graphics.getWidth()/4.4, love.graphics.getHeight() - 0.98 * love.graphics.getHeight())

    if debug then
        cameraController:draw()
        Util.l.resetColour()
        Util.l.renderStats()
    end
end

function love.keypressed(key)
    if key == "f1" then
        debug = not debug
    elseif key == "escape" then
        love.event.quit()
    elseif key == "f5" then
        love.event.quit("restart")
    end

    inputController:keypressed(key)
end

function love.mousepressed(x, y, button, istouch, presses)
    inputController:mousepressed(x, y, button)
end