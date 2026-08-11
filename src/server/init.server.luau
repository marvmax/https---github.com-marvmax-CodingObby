print("Hello world, from server!")

-- Safely wait for the 'Modules' folder and the 'Data' ModuleScript
local scriptServer = game:GetService("ServerScriptService")
local modulesFolder = scriptServer:WaitForChild("Modules")
--[[
local modules = server:WaitForChild("Modules")
local Data = require(Modules:WaitForChild("Data"))
data.sayHello() -- Call the sayHello function from the Data module
]]

for key, value in pairs(game:GetService("ServerScriptService"):GetChildren()) do
	if value:IsA("ModuleScript") then
		print("ModuleScript found: " .. value.Name)
	else
		print("Not a ModuleScript: " .. value.Name)
	end
end
