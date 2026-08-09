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

return utilities
