--[[ 
    LCC HUB OBFUSCADOR
    LocalScript | Executor: Delta
]]

-- Serviços
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local lp = Players.LocalPlayer

-- Remove UI antiga
pcall(function()
    if CoreGui:FindFirstChild("LccHubObfuscator") then
        CoreGui.LccHubObfuscator:Destroy()
    end
end)

-- Função de gerar texto aleatório
local function randomString(len)
    local chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
    local str = ""
    for i = 1, len do
        local r = math.random(1, #chars)
        str = str .. chars:sub(r, r)
    end
    return str
end

-- Função de obfuscação simples
local function obfuscate(code)
    local var = randomString(15)
    local encoded = {}
    
    for i = 1, #code do
        table.insert(encoded, string.byte(code:sub(i, i)))
    end
    
    local result = "local "..var.."={"..table.concat(encoded, ",").."} "
    result = result .. "local _='' for i=1,#"..var.." do _= _..string.char("..var.."[i]) end "
    result = result .. "loadstring(_)()"
    
    return result
end

-- UI
local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "LccHubObfuscator"
ScreenGui.ResetOnSpawn = false

local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 520, 0, 360)
Main.Position = UDim2.new(0.5, -260, 0.5, -180)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true

local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
Title.Text = "LCC HUB • OBFUSCADOR"
Title.TextColor3 = Color3.fromRGB(120, 170, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.BorderSizePixel = 0

-- Botão FECHAR
local CloseBtn = Instance.new("TextButton", Main)
CloseBtn.Size = UDim2.new(0, 35, 0, 35)
CloseBtn.Position = UDim2.new(1, -40, 0, 3)
CloseBtn.BackgroundColor3 = Color3.fromRGB(140, 50, 50)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255,255,255)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 18
CloseBtn.BorderSizePixel = 0

local Box = Instance.new("TextBox", Main)
Box.Size = UDim2.new(1, -20, 1, -120)
Box.Position = UDim2.new(0, 10, 0, 50)
Box.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
Box.TextColor3 = Color3.fromRGB(230, 230, 230)
Box.TextXAlignment = Enum.TextXAlignment.Left
Box.TextYAlignment = Enum.TextYAlignment.Top
Box.ClearTextOnFocus = false
Box.MultiLine = true
Box.TextWrapped = true
Box.Font = Enum.Font.Code
Box.TextSize = 14
Box.Text = "-- Cole seu código Lua aqui"
Box.BorderSizePixel = 0

-- Botões
local ObfBtn = Instance.new("TextButton", Main)
ObfBtn.Size = UDim2.new(0.3, 0, 0, 40)
ObfBtn.Position = UDim2.new(0.05, 0, 1, -55)
ObfBtn.BackgroundColor3 = Color3.fromRGB(40, 80, 160)
ObfBtn.Text = "OBFUSCAR"
ObfBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ObfBtn.Font = Enum.Font.GothamBold
ObfBtn.TextSize = 16
ObfBtn.BorderSizePixel = 0

local CopyBtn = Instance.new("TextButton", Main)
CopyBtn.Size = UDim2.new(0.3, 0, 0, 40)
CopyBtn.Position = UDim2.new(0.35, 0, 1, -55)
CopyBtn.BackgroundColor3 = Color3.fromRGB(40, 140, 90)
CopyBtn.Text = "COPIAR"
CopyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CopyBtn.Font = Enum.Font.GothamBold
CopyBtn.TextSize = 16
CopyBtn.BorderSizePixel = 0

local ClearBtn = Instance.new("TextButton", Main)
ClearBtn.Size = UDim2.new(0.3, 0, 0, 40)
ClearBtn.Position = UDim2.new(0.65, 0, 1, -55)
ClearBtn.BackgroundColor3 = Color3.fromRGB(120, 40, 40)
ClearBtn.Text = "CLEAR"
ClearBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ClearBtn.Font = Enum.Font.GothamBold
ClearBtn.TextSize = 16
ClearBtn.BorderSizePixel = 0

-- Botão ABRIR
local OpenBtn = Instance.new("TextButton", ScreenGui)
OpenBtn.Size = UDim2.new(0, 120, 0, 40)
OpenBtn.Position = UDim2.new(0, 10, 0.5, -20)
OpenBtn.BackgroundColor3 = Color3.fromRGB(40, 80, 160)
OpenBtn.Text = "ABRIR LCC"
OpenBtn.TextColor3 = Color3.fromRGB(255,255,255)
OpenBtn.Font = Enum.Font.GothamBold
OpenBtn.TextSize = 14
OpenBtn.BorderSizePixel = 0
OpenBtn.Visible = false
OpenBtn.Active = true
OpenBtn.Draggable = true

-- Funções
ObfBtn.MouseButton1Click:Connect(function()
    if Box.Text ~= "" then
        Box.Text = obfuscate(Box.Text)
    end
end)

CopyBtn.MouseButton1Click:Connect(function()
    if Box.Text ~= "" and setclipboard then
        setclipboard(Box.Text)
        CopyBtn.Text = "COPIADO!"
        task.delay(1.5, function()
            CopyBtn.Text = "COPIAR"
        end)
    end
end)

ClearBtn.MouseButton1Click:Connect(function()
    Box.Text = ""
end)

CloseBtn.MouseButton1Click:Connect(function()
    Main.Visible = false
    OpenBtn.Visible = true
end)

OpenBtn.MouseButton1Click:Connect(function()
    Main.Visible = true
    OpenBtn.Visible = false
end)
