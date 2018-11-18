UiController = Class {
    init = function(self)
        self.resizeTriggered = true
        self.mainMenu = true
        self.buildMenu = false
        self.upgradeMenu = false
        self.firstRun = true
        self.choice = 0
        self.styles = {
            CRUCIBLE = {
                ['window'] = {
                    ['background'] = '#c89870',
                    ['fixed background'] = assets.ui.menuCrucible,
                },
                ['button'] = {
                    ['normal'] = assets.ui.slotClean,
                    ['hover'] = assets.ui.slotCleanHovered,
                    ['active'] = assets.ui.slotClean,
                },
            },
            MAIN_MENU = {
                ['text'] = {
                    ['color'] = '#000000', 
                },
                ['window'] = {
                    ['background'] = '#c89870',
                    ['fixed background'] = assets.ui.menuRight,
                },
                ['button'] = {
                    ['normal'] = assets.ui.button,
                    ['hover'] = assets.ui.buttonHovered,
                    ['active'] = assets.ui.button,
                    ['text background'] = '#c89870',
                    ['text normal'] = '#000000',
                    ['text hovered'] = '#FFFFFF',
                    ['text active'] = '#000000',
                },
            },
            SELECT_MENU = {
                ['text'] = {
                    ['color'] = '#000000', 
                },
                ['window'] = {
                    ['background'] = '#c89870',
                    ['fixed background'] = assets.ui.menuLeft,
                },
                ['button'] = {
                    ['normal'] = assets.ui.button,
                    ['hover'] = assets.ui.buttonHovered,
                    ['active'] = assets.ui.button,
                    ['text background'] = '#c89870',
                    ['text normal'] = '#000000',
                    ['text hovered'] = '#FFFFFF',
                    ['text active'] = '#000000',
                },
            },
        }
    end;
    triggerResize = function(self)
        self.resizeTriggered = true
    end;
    handleResize = function(self, x, y, width, height)
        if self.resizeTriggered then
            nk.windowSetBounds(x, y, width, height)
        end
    end;
    update = function(self, dt)
        local windowWidth = love.graphics.getWidth()
        local windowHeight = love.graphics.getHeight()
        nk.frameBegin()
            if nk.windowBegin('Wallet', constants.UI.WALLET.X*windowWidth, constants.UI.WALLET.Y*windowHeight, constants.UI.WALLET.WIDTH*windowWidth, constants.UI.WALLET.HEIGHT*windowHeight) then

                self:handleResize(constants.UI.WALLET.X*windowWidth, constants.UI.WALLET.Y*windowHeight, constants.UI.WALLET.WIDTH*windowWidth, constants.UI.WALLET.HEIGHT*windowHeight)
            
                local width, height = nk.windowGetSize()
                nk.layoutRowBegin('dynamic', height*0.6, playerController.wallet.totalCurrencies)
                for key, currency in pairs(playerController.wallet.currencies) do
                    nk.layoutRowPush(1/playerController.wallet.totalCurrencies)
                    nk.label(currency.value, 'centered', nk.colorRGBA(currency:colourRGB()))
                end
                nk.layoutRowEnd()
            end
            nk.windowEnd()

            if roundController:isBuildPhase() then 
                nk.stylePush(self.styles.MAIN_MENU)
                if nk.windowBegin('Menu', constants.UI.MENU.X*windowWidth, constants.UI.MENU.Y*windowHeight, constants.UI.MENU.WIDTH*windowWidth, constants.UI.MENU.HEIGHT*windowHeight) then
                    self:handleResize(constants.UI.MENU.X*windowWidth, constants.UI.MENU.Y*windowHeight, constants.UI.MENU.WIDTH*windowWidth, constants.UI.MENU.HEIGHT*windowHeight)    
                    
                    if self.mainMenu then 
                        nk.layoutRow('dynamic', (constants.UI.MENU.LAYOUTROW_HEIGHT*windowHeight), 2)
                        if nk.button('Build') then 
                            self.mainMenu = false
                            self.buildMenu = true
                        end
                        if nk.button('Start Wave') then
                            if world.grid.validPath then
                                roundController:startRound()
                            end
                        end
                    elseif self.buildMenu then 
                        nk.layoutRow('dynamic', (constants.UI.MENU.LAYOUTROW_HEIGHT*windowHeight), 5)
                        if nk.button('', assets.blueprints.obstacle) then 
                            playerController:setCurrentBlueprint(1)
                        end
                        if nk.button('', assets.blueprints.saw) then 
                            playerController:setCurrentBlueprint(2)
                        end
                        nk.layoutRow('dynamic', (constants.UI.MENU.LAYOUTROW_HEIGHT*windowHeight), 5)
                        if nk.button('', assets.blueprints.cannon) then 
                            playerController:setCurrentBlueprint(3)
                        end
                        nk.spacing(3)
                        if nk.button('Back') then
                            self.buildMenu = false
                            self.mainMenu = true
                        end
                    end 
                end
                nk.windowEnd()
                nk.stylePop()

                if nk.windowBegin(constants.UI.OPTIONS_MENU.NAME, constants.UI.OPTIONS_MENU.X*windowWidth, constants.UI.OPTIONS_MENU.Y*windowHeight, constants.UI.OPTIONS_MENU.WIDTH*windowWidth, constants.UI.OPTIONS_MENU.HEIGHT*windowHeight) then 
                    self:handleResize(constants.UI.OPTIONS_MENU.X*windowWidth, constants.UI.OPTIONS_MENU.Y*windowHeight, constants.UI.OPTIONS_MENU.WIDTH*windowWidth, constants.UI.OPTIONS_MENU.HEIGHT*windowHeight)
                    nk.layoutRow('dynamic', (constants.UI.OPTIONS_MENU.LAYOUTROW_HEIGHT*windowHeight), {(1)})
                    if nk.button("Resume Game") then 
                        nk.windowHide(constants.UI.OPTIONS_MENU.NAME)
                    end 
                    nk.layoutRow('dynamic', (constants.UI.OPTIONS_MENU.LAYOUTROW_HEIGHT*windowHeight), {(1)})
                    if nk.button("Sound") then 
                        nk.windowHide(constants.UI.OPTIONS_MENU.NAME)
                        nk.windowShow(constants.UI.OPTIONS_SOUND.NAME)
                    end 
                    nk.layoutRow('dynamic', (constants.UI.OPTIONS_MENU.LAYOUTROW_HEIGHT*windowHeight), 1)
                    if nk.button("Exit Game") then 
                        love.event.quit()
                    end 
                    if self.firstRun then
                        nk.windowHide(constants.UI.OPTIONS_MENU.NAME)
                    end
                else 
                    nk.windowHide(constants.UI.OPTIONS_MENU.NAME)
                end
                nk.windowEnd()

                if nk.windowBegin(constants.UI.OPTIONS_BUTTON.NAME, constants.UI.OPTIONS_BUTTON.X*windowWidth, constants.UI.OPTIONS_BUTTON.Y*windowHeight, constants.UI.OPTIONS_BUTTON.WIDTH*windowWidth, constants.UI.OPTIONS_BUTTON.HEIGHT*windowHeight) then 
                    self:handleResize(constants.UI.OPTIONS_BUTTON.X*windowWidth, constants.UI.OPTIONS_BUTTON.Y*windowHeight, constants.UI.OPTIONS_BUTTON.WIDTH*windowWidth, constants.UI.OPTIONS_BUTTON.HEIGHT*windowHeight)
                    nk.layoutRow('dynamic', (constants.UI.OPTIONS_BUTTON.LAYOUTROW_HEIGHT*windowHeight), 1)
                    if nk.button("OPTIONS") then 
                        nk.windowShow(constants.UI.OPTIONS_MENU.NAME)
                    end 
                end
                nk.windowEnd()

                if nk.windowBegin(constants.UI.OPTIONS_SOUND.NAME, constants.UI.OPTIONS_SOUND.X*windowWidth, constants.UI.OPTIONS_SOUND.Y*windowHeight, constants.UI.OPTIONS_SOUND.WIDTH*windowWidth, constants.UI.OPTIONS_SOUND.HEIGHT*windowHeight) then 
                    self:handleResize(constants.UI.OPTIONS_SOUND.X*windowWidth, constants.UI.OPTIONS_SOUND.Y*windowHeight, constants.UI.OPTIONS_SOUND.WIDTH*windowWidth, constants.UI.OPTIONS_SOUND.HEIGHT*windowHeight)
                    nk.layoutRow('dynamic', (constants.UI.OPTIONS_MENU.LAYOUTROW_HEIGHT*windowHeight), 1)
                    nk.label("Music Volume:") 
                    nk.layoutRow('dynamic', (constants.UI.OPTIONS_SOUND.LAYOUTROW_HEIGHT*windowHeight), 1)
                    audioController.music.volume = nk.slider(0, audioController.music.volume, 1, 0.01)
                    nk.layoutRow('dynamic', (constants.UI.OPTIONS_SOUND.LAYOUTROW_HEIGHT*windowHeight*0.5), 1)
                    if nk.button("Back") then 
                        nk.windowHide(constants.UI.OPTIONS_SOUND.NAME)
                        nk.windowShow(constants.UI.OPTIONS_MENU.NAME)
                    end 

                    if self.firstRun then
                        nk.windowHide(constants.UI.OPTIONS_SOUND.NAME)
                    end
                else 
                    nk.windowHide(constants.UI.OPTIONS_SOUND.NAME)
                end
                nk.windowEnd()



                nk.stylePush(self.styles.MAIN_MENU)
                if nk.windowBegin('Rounds', constants.UI.ROUNDS.X*windowWidth, constants.UI.ROUNDS.Y*windowHeight, constants.UI.ROUNDS.WIDTH*windowWidth, constants.UI.ROUNDS.HEIGHT*windowHeight) then
                    self:handleResize(constants.UI.ROUNDS.X*windowWidth, constants.UI.ROUNDS.Y*windowHeight, constants.UI.ROUNDS.WIDTH*windowWidth, constants.UI.ROUNDS.HEIGHT*windowHeight)
                    nk.layoutRow('dynamic', (constants.UI.ROUNDS.LAYOUTROW_HEIGHT*windowHeight), {1/2, 1/2})
                    nk.label('Rounds:')
                    nk.label('50')
                end
                nk.windowEnd()
                nk.stylePop()

                nk.stylePush(self.styles.CRUCIBLE)
                if nk.windowBegin('Crucible', constants.UI.CRUCIBLE.X*windowWidth, constants.UI.CRUCIBLE.Y*windowHeight, constants.UI.CRUCIBLE.WIDTH*windowWidth, constants.UI.CRUCIBLE.HEIGHT*windowHeight) then
                    self:handleResize(constants.UI.CRUCIBLE.X*windowWidth, constants.UI.CRUCIBLE.Y*windowHeight, constants.UI.CRUCIBLE.WIDTH*windowWidth, constants.UI.CRUCIBLE.HEIGHT*windowHeight)
                    nk.layoutRow('dynamic', (constants.UI.CRUCIBLE.LAYOUTROW_HEIGHT*windowHeight), {(1/3),(1/3),(1/3)})
                    for i=1, #roundController.crucible.slots do 
                        local blueprint = roundController.crucible.slots[i].blueprint
                        if i+1 % 3 == 0 then
                            nk.layoutRow('dynamic', (constants.UI.CRUCIBLE.LAYOUTROW_HEIGHT*windowHeight), {(1/3),(1/3),(1/3)})
                        end

                        if blueprint then
                            nk.stylePush({
                                ['button'] = {
                                    ['normal'] = blueprint.image,
                                    ['hover'] = blueprint.image,
                                    ['active'] = blueprint.image,
                                },
                            })
                        end
                
                        if nk.button('') then
                            self.choice = i
                            nk.windowShow(constants.UI.PICKER.NAME)
                            playerController:toggleStructureSelection(playerController.currentSelectedStructure)
                        end


                        if blueprint then
                            nk.stylePop()
                        end
                    end
                end
                nk.windowEnd()
                nk.stylePop()


                if nk.windowBegin(constants.UI.PICKER.NAME, '', constants.UI.PICKER.X*windowWidth, constants.UI.PICKER.Y*windowHeight, constants.UI.PICKER.WIDTH*windowWidth, constants.UI.PICKER.HEIGHT*windowHeight, 'border','scrollbar','closable') then
                    self:handleResize(constants.UI.PICKER.X*windowWidth, constants.UI.PICKER.Y*windowHeight, constants.UI.PICKER.WIDTH*windowWidth, constants.UI.PICKER.HEIGHT*windowHeight)
                    
                    for i, blueprint in pairs(roundController.ENEMY_BLUEPRINTS) do
                        nk.layoutRow('dynamic', (constants.UI.PICKER.LAYOUTROW_HEIGHT*windowHeight), {(1/6),(1/6),(1/6),(1/6),(1/6),(1/6)})
                        if nk.button('', blueprint.image) then
                            roundController.crucible.slots[self.choice]:setBlueprint(blueprint)
                        end
                        nk.spacing(2)
                        nk.label(blueprint.name)
                    end

                    if self.firstRun then
                        nk.windowHide(constants.UI.PICKER.NAME)
                    end
                else -- Allow 'close' button to work
                    nk.windowHide(constants.UI.PICKER.NAME)
                end
                nk.windowEnd()

                nk.stylePush(self.styles.SELECT_MENU)
                if nk.windowBegin('Selected', constants.UI.SELECTED.X*windowWidth, constants.UI.SELECTED.Y*windowHeight, constants.UI.SELECTED.WIDTH*windowWidth, constants.UI.SELECTED.HEIGHT*windowHeight) then
                    self:handleResize(constants.UI.SELECTED.X*windowWidth, constants.UI.SELECTED.Y*windowHeight, constants.UI.SELECTED.WIDTH*windowWidth, constants.UI.SELECTED.HEIGHT*windowHeight)                        
                    if playerController.currentSelectedStructure ~= nil then 
                        if self.upgradeMenu then 
                            nk.layoutRow('dynamic', (constants.UI.SELECTED.LAYOUTROW_HEIGHT*windowHeight), 5)
                            if nk.button('Fire') then 
                                if playerController.currentSelectedStructure.mutable and playerController.wallet:canAfford(constants.MUTATIONS.FIRE.COST) then
                                    playerController.currentSelectedStructure:addMutation(FireMutation()) 
                                    self.upgradeMenu = false
                                end
                            end
                            if nk.button('Ice') then 
                                if playerController.currentSelectedStructure.mutable and playerController.wallet:canAfford(constants.MUTATIONS.ICE.COST) then
                                    playerController.currentSelectedStructure:addMutation(IceMutation()) 
                                    self.upgradeMenu = false
                                end
                            end
                            nk.layoutRow('dynamic', (constants.UI.SELECTED.LAYOUTROW_HEIGHT*windowHeight), 5)
                            if nk.button('Elec') then 
                                if playerController.currentSelectedStructure.mutable and playerController.wallet:canAfford(constants.MUTATIONS.ELECTRIC.COST) then
                                    playerController.currentSelectedStructure:addMutation(ElectricMutation()) 
                                    self.upgradeMenu = false
                                end                           
                            end
                            nk.spacing(3)
                            if nk.button('Back') then 
                                self.upgradeMenu = false
                            end
                        else
                            nk.layoutRow('dynamic', (constants.UI.SELECTED.LAYOUTROW_HEIGHT*windowHeight), 2)
                            if nk.button('Upgrade') then 
                                self.upgradeMenu = true
                            end
                            if nk.button('Refund') then 
                                playerController:refundCurrentStructure()
                                self.upgradeMenu = false
                            end
                        end
                    end
                end
                nk.windowEnd()
                nk.stylePop()

                nk.stylePush(self.styles.SELECT_MENU)
                if nk.windowBegin('Stats', constants.UI.STATS.X*windowWidth, constants.UI.STATS.Y*windowHeight, constants.UI.STATS.WIDTH*windowWidth, constants.UI.STATS.HEIGHT*windowHeight) then
                    self:handleResize(constants.UI.STATS.X*windowWidth, constants.UI.STATS.Y*windowHeight, constants.UI.STATS.WIDTH*windowWidth, constants.UI.STATS.HEIGHT*windowHeight)
                    nk.layoutRow('dynamic', (constants.UI.STATS.LAYOUTROW_HEIGHT*windowHeight), {0.2, 0.8})
                    nk.spacing(1)

                end
                nk.windowEnd()
                nk.stylePop()
            end
 
            if self.firstRun then
                self.firstRun = false
            end
        nk.frameEnd()
        self.resizeTriggered = false
    end;
    draw = function(self)
        Util.l.resetColour()
        nk.draw()
        if playerController.currentSelectedStructure then
            if roundController:isBuildPhase() then 
                playerController.currentSelectedStructure:doThing(Vector(constants.UI.STATS.IMG_X*love.graphics.getWidth(), constants.UI.STATS.IMG_Y*love.graphics.getHeight()))
            end
        end
    end;
}