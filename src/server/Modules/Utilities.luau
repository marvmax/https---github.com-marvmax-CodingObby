local utilities = {}

utilities.recursiveCopy = function(source, destination)
	local tableCopy = {}
	for index, value in dataTable do
		if type(value) == "table" then
			value = utilities.recursiveCopy(value)
		end
		tableCopy[index] = value
	end
	return tableCopy
end

utilities.promiseReturn = function(maxRetries, callback, retries, err)
	if maxRetries and not retries then
		retries = 0
	elseif retries and retries >= maxRetries then
		warn(err, "Max retries reached: " .. maxRetries)
		return false
	end

	local result

	local success, err = pcall(function()
		result = callback()
	end)
	if success then
		return success, result
	else
		task.wait()
		if retries then
			retries = retries + 1
		else
			retries = 1
		end
		return utilities.promiseReturn(maxRetries, callback, retries, err)
	end
end

return utilities
