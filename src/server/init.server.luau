print("Hello world, from server!")

-- Safely wait for the 'Modules' folder and the 'Data' ModuleScript
local modulesFolder = game.ServerScriptService.Server.Modules

for i, v in modulesFolder:GetChildren() do
	if v.Name == "Data" and v:IsA("ModuleScript") then
		local data = require(v)
		data.sayHello() -- Call the sayHello function from the Data module
		break
	end
end

local data = require(modulesFolder["Data.module"])

task.wait(1) -- Wait for 1 second to ensure the module is loaded

data.sayHello() -- Call the sayHello function from the Data module
