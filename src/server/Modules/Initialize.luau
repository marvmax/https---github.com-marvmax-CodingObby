local playerService = game:GetService("Players")

local modulesFolder = game.ServerScriptService.Server.Modules
local dataMod = require(modulesFolder["Data"])

local initializeMod = {}

local function getStage(stageNum)
    for _, stagePart in spawnParts:GetChildren() do
        if stagePart:GetAttribute("Stage") == stageNum then
            return stagePart    
        end
    end
end

playerService.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(char)
        local stage = dataMod:get(player, "Stage")
        local spawnPart = getStage(stageNum)
        char:PivotTo(spawnPoint.CFrame * CFrame.new(0,0,0)
    end)
end)

return initializeMod