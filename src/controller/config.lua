ConfigController = Class {
    init = function(self)
        self.settings = {}
        self.DEFAULT_SETTINGS = {
            music_multiplier = 1,
            sfx_multiplier = 1
        }
    end;
    fetchUserSettings = function(self)
        local contents, size = love.filesystem.read('settings.lua')
        if contents then
            local data = setfenv(loadstring(contents), {})()
            if data and data.sfx_multiplier and data.music_multiplier then
                self.settings = data
            else
                self.settings = self.DEFAULT_SETTINGS
                self:saveUserSettings()
            end
        else 
            -- no settings file, use defaults
            self.settings = self.DEFAULT_SETTINGS
            self:saveUserSettings()
        end
    end;
    saveUserSettings = function(self)
        local file = love.filesystem.newFile('settings.lua')
        file:open("w")
        file:write(serialize(self.settings))
    end;
}