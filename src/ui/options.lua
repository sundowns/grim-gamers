
Options = Class {
    init = function(self)

    end; 

    display = function(self, windowWidth, windowHeight)
        if nk.windowBegin(constants.UI.OPTIONS_MENU.NAME, constants.UI.OPTIONS_MENU.X*windowWidth, constants.UI.OPTIONS_MENU.Y*windowHeight, constants.UI.OPTIONS_MENU.WIDTH*windowWidth, constants.UI.OPTIONS_MENU.HEIGHT*windowHeight) then 
            uiController:handleResize(constants.UI.OPTIONS_MENU.X*windowWidth, constants.UI.OPTIONS_MENU.Y*windowHeight, constants.UI.OPTIONS_MENU.WIDTH*windowWidth, constants.UI.OPTIONS_MENU.HEIGHT*windowHeight)
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
            if uiController.firstRun then
                nk.windowHide(constants.UI.OPTIONS_MENU.NAME)
            end
        else 
            nk.windowHide(constants.UI.OPTIONS_MENU.NAME)
        end
        nk.windowEnd()

        if nk.windowBegin(constants.UI.OPTIONS_BUTTON.NAME, constants.UI.OPTIONS_BUTTON.X*windowWidth, constants.UI.OPTIONS_BUTTON.Y*windowHeight, constants.UI.OPTIONS_BUTTON.WIDTH*windowWidth, constants.UI.OPTIONS_BUTTON.HEIGHT*windowHeight) then 
            uiController:handleResize(constants.UI.OPTIONS_BUTTON.X*windowWidth, constants.UI.OPTIONS_BUTTON.Y*windowHeight, constants.UI.OPTIONS_BUTTON.WIDTH*windowWidth, constants.UI.OPTIONS_BUTTON.HEIGHT*windowHeight)
            nk.layoutRow('dynamic', (constants.UI.OPTIONS_BUTTON.LAYOUTROW_HEIGHT*windowHeight), 1)
            if nk.button("OPTIONS") then 
                nk.windowShow(constants.UI.OPTIONS_MENU.NAME)
            end 
        end
        nk.windowEnd()

        if nk.windowBegin(constants.UI.OPTIONS_SOUND.NAME, constants.UI.OPTIONS_SOUND.X*windowWidth, constants.UI.OPTIONS_SOUND.Y*windowHeight, constants.UI.OPTIONS_SOUND.WIDTH*windowWidth, constants.UI.OPTIONS_SOUND.HEIGHT*windowHeight) then 
            uiController:handleResize(constants.UI.OPTIONS_SOUND.X*windowWidth, constants.UI.OPTIONS_SOUND.Y*windowHeight, constants.UI.OPTIONS_SOUND.WIDTH*windowWidth, constants.UI.OPTIONS_SOUND.HEIGHT*windowHeight)
            nk.layoutRow('dynamic', (constants.UI.OPTIONS_MENU.LAYOUTROW_HEIGHT*windowHeight), 1)
            nk.label("Music Volume:") 
            nk.layoutRow('dynamic', (constants.UI.OPTIONS_SOUND.LAYOUTROW_HEIGHT*windowHeight), 1)
            audioController.music.volume = nk.slider(0, audioController.music.volume, 1, 0.01)
            nk.layoutRow('dynamic', (constants.UI.OPTIONS_SOUND.LAYOUTROW_HEIGHT*windowHeight*0.5), 1)
            if nk.button("Back") then 
                nk.windowHide(constants.UI.OPTIONS_SOUND.NAME)
                nk.windowShow(constants.UI.OPTIONS_MENU.NAME)
            end 

            if uiController.firstRun then
                nk.windowHide(constants.UI.OPTIONS_SOUND.NAME)
            end
        else 
            nk.windowHide(constants.UI.OPTIONS_SOUND.NAME)
        end
        nk.windowEnd()
    end;
}
