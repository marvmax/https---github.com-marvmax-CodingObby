local playerService = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local badgeService = game:GetService("BadgeService")

local modulesFolder = game.ServerScriptService.Server.Modules
local dataMod = require(modulesFolder["Data"])
local utilitiesMod = require(modulesFolder["Utilities"]))

local partFunctionsMod = {}
local coinCodes = {}
local uniqueCode = 0

partFunctionsMod.playerFromHit = function(hit)
	local char = hit:FindFirstAncestorOfClass("Model")
	local player = playerService:GetPlayerFromCharacter(char)

	return player, char
end

partFunctionsMod.BadgeParts = function(part)
    local badgeId = part:GetAttribute("BadgeId")

    part.Touched:Connect(function(hit)
        local player = partFunctionsMod.playerFromHit(hit)

        if player then
            local key = player.UserId
            local hasBadge = utilitiesMod.promiseReturn(1, function()
                return badgeService:AwardBadgeAsync(userId, badgeId)
            end)
            if not hasBadge then
                utilitiesMod.promiseReturn(1, function()
                    badgeService:AwardBadgeAsync(userId, badgeId)
                end)
            end
        end
    end)
end

partFunctionsMod.KillParts = function(part)
	part.Touched:Connect(function(hit)
		local player, char = partFunctionsMod.playerFromHit(hit)
		if player and char.Humandoid.Health > 0 then
			char.Humanoid.Health = 0
		end
	end)
end

partFunctionsMod.DamageParts = function(part)
    local debounce = false
    local damage = part:GetAttribute("Damage")

    part.Touched:Connect(function(hit)
        local player, char = partFunctionsMod.playerFromHit(hit)
        if player and not debounce then
            debounce = true
            local hum = char.Humanoid
            hum:TakeDamage(damage)

            task.delay(.1, function()
                debounce = false
            end)
        end
    end)
end

partFunctionsMod.SpawnParts = function(part)
    local stage = part:GetAttribute("Stage")
    part.Touched:Connect(function(hit)
        local player, char = partFunctionsMod.playerFromHit(hit)
        if player and dataMod.get(player, "Stage") == stage - 1 then
            dataMod.set(player, "Stage", stage)
        end
    end)
end

partFunctionsMod.RewardParts = function(part)
    local reward = part:GetAttribute("Reward")
    local code = uniqueCode
    uniqueCode = uniqueCode + 1

    part.Touched:Connect(function()
        local player = partFunctionsMod.playerFromHit(hit)

        if player then
            local playerCoinCodes = coinCodes[player.UserId]
            if not table.find(playerCoinCodes, code) then
                dataMod.increment(player, "Coins", reward)
                table.insert(playerCoinCodes, code)
                replicatedStorage.Effect:FireClient(player, part)
            end
        end
    end)
end




local partGroups = {
    workspace.KillParts;
    workspace.DamageParts;
    workspace.SpawnParts;
    workspace.RewardParts;
    workspace.BadgeParts;
}

for _, group in partGroups do
    for _, part in group:GetChildren() do
        if part:IsA("BasePart") then
            partFunctionsMod[group.Name](part)
    end
end


playerService.PlayerAdded:Connect(function(player)
	coinCodes[player.UserId] = {}
end)

playerService.PlayerRemoving:Connect(function(player)
	coinCodes[player.UserId] = nil
end)

return partFunctionsMod
