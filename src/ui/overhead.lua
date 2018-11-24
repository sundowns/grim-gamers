Overhead = Class {
    init = function(self)      
        self.style = {
            ['window'] = {
                ['fixed background'] = assets.ui.menuRight,
                ['padding'] = {x = 0, y = 19}
            },
            ['button'] = {
                ['normal'] = assets.ui.button,
                ['hover'] = assets.ui.buttonHovered,
                ['active'] = assets.ui.button,
                ['text background'] = constants.COLOURS.UI.PANEL_TRANSPARENT_LIGHT,
                ['text normal'] = constants.COLOURS.UI.BLACK,
                ['text hovered'] = constants.COLOURS.UI.WHITE,
                ['text active'] = constants.COLOURS.UI.BLACK,
            }
        }
    end; 
    draw = function(self)
        local count = 1
        for key, currency in pairs(playerController.wallet.currencies) do
            Util.l.resetColour()
            love.graphics.draw(currency.image, love.graphics.getWidth() - (2 * playerController.wallet.totalCurrencies) - (count * 90) - 50, love.graphics.getHeight()/50)
            love.graphics.setColor(0, 0, 0)
            love.graphics.print(currency.value, love.graphics.getWidth() - (2 * playerController.wallet.totalCurrencies) - (count * 90) - 25, love.graphics.getHeight()/50)
            count = count + 1
        end
        love.graphics.print('Round: '.. roundController.roundIndex .. ' / ' .. roundController.totalRounds, love.graphics.getWidth()/4, love.graphics.getHeight()/50)
        love.graphics.print('Lives: '.. playerController.livesRemaining .. ' / ' .. constants.MISC.STARTING_LIVES, love.graphics.getWidth()/2, love.graphics.getHeight()/50)
    end;

    display = function(self, windowWidth, windowHeight)
        nk.stylePush(self.style)
        if nk.windowBegin('Overhead', constants.UI.OVERHEAD.X*windowWidth, constants.UI.OVERHEAD.Y*windowHeight, constants.UI.OVERHEAD.WIDTH*windowWidth, constants.UI.OVERHEAD.HEIGHT*windowHeight) then
            uiController:handleResize(constants.UI.OVERHEAD.X*windowWidth, constants.UI.OVERHEAD.Y*windowHeight, constants.UI.OVERHEAD.WIDTH*windowWidth, constants.UI.OVERHEAD.HEIGHT*windowHeight)
            nk.layoutRow('dynamic', constants.UI.OVERHEAD.LAYOUTROW_HEIGHT, {0.15, 0.85})
            if nk.windowIsHovered() and not nk.widgetIsHovered() then 
                if not nk.windowHasFocus() then 
                    nk.windowSetFocus('Overhead')
                end
            end
            if nk.button("OPTIONS") then 
                nk.windowShow(constants.UI.OPTIONS_MENU.NAME)
            end 
            nk.spacing(1)
        end
        nk.windowEnd()
        nk.stylePop()
    end;
}