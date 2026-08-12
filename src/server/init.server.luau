print("Hello world, from server!")

-- Safely wait for the 'Modules' folder and the 'Data' ModuleScript
local modulesFolder = game.ServerScriptService.Server.Modules

local data = require(modulesFolder["Data"])

--task.wait(1) -- Wait for 1 second to ensure the module is loaded

data.sayHello() -- Call the sayHello function from the Data module
