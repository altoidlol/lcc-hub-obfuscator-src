local input = {} -- put the ascii bytes here

local function Deobfuscate(bytes)
    local result = ""
    
    for i = 1, #bytes do
        result = result..string.char(bytes[i])
    end
    
    return result
end

print(Deobfuscate(input))
