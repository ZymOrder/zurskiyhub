-- [[ ZURSKIY HUB V3: ULTRA-PREMIUM EDITION ]] --

local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local lp = Players.LocalPlayer

-- === ТВОИ КЛЮЧИ (ЗДЕСЬ МЫ ПРОПИСАЛИ ТЕБЯ И ДРУГА) ===
local PremiumKeys = {
    "OwnerUltra", -- Твой личный ключ
    "FUltra",      -- Ключ для друга
    "ZUR-FREE-KEY" -- Тестовый ключ
}

local vars = {
    isPremium = false,
    noclip = false,
    fly = false,
    infjump = false,
    killaura = false,
    speed = 16
}

-- ИНТЕРФЕЙС
local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 260, 0, 420)
Main.Position = UDim2.new(0.5, -130, 0.5, -210)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
Main.Active = true
Main.Draggable = true 
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 15)
local Stroke = Instance.new("UIStroke", Main)
Stroke.Color = Color3.fromRGB(138, 43, 226)
Stroke.Thickness = 2

local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 45)
Title.Text = "ZURSKIY HUB V3"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = "GothamBold"
Title.TextSize = 18
Title.BackgroundTransparency = 1

local Scroll = Instance.new("ScrollingFrame", Main)
Scroll.Size = UDim2.new(1, -10, 1, -110)
Scroll.Position = UDim2.new(0, 5, 0, 50)
Scroll.BackgroundTransparency = 1
Scroll.CanvasSize = UDim2.new(0, 0, 0, 1000)
Scroll.ScrollBarThickness = 2
local Layout = Instance.new("UIListLayout", Scroll)
Layout.Padding = UDim.new(0, 5)
Layout.HorizontalAlignment = "Center"

-- Хелперы
local function AddToggle(text, callback)
    local btn = Instance.new("TextButton", Scroll)
    btn.Size = UDim2.new(0, 230, 0, 35)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    btn.Text = text .. ": OFF"
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = "Gotham"
    Instance.new("UICorner", btn)
    local state = false
    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.Text = text .. (state and ": ON" or ": OFF")
        btn.BackgroundColor3 = state and Color3.fromRGB(80, 0, 200) or Color3.fromRGB(30, 30, 40)
        callback(state)
    end)
end

-- ФУНКЦИЯ РАЗБЛОКИРОВКИ УЛЬТРА-ПРЕМИУМА
local function UnlockUltra(ownerName)
    vars.isPremium = true
    Title.Text = "ZURSKIY [ULTRA]"
    Title.TextColor3 = Color3.fromRGB(255, 215, 0)
    
    -- Эффект переливающейся рамки
    task.spawn(function()
        while true do
            for i = 0, 1, 0.01 do
                Stroke.Color = Color3.fromHSV(i, 1, 1)
                task.wait(0.05)
            end
        end
    end)

    -- Эксклюзивные Ультра-функции
    AddToggle("🌟 ULTRA KILL AURA", function(state)
        vars.killaura = state
        while vars.killaura do
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= lp and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    local dist = (lp.Character.HumanoidRootPart.Position - p.Character.HumanoidRootPart.Position).magnitude
                    if dist < 25 then
                        -- Здесь логика атаки
                    end
                end
            end
            task.wait(0.2)
        end
    end)

    AddToggle("🌟 GHOST MODE", function(state)
        if lp.Character then
            for _, v in pairs(lp.Character:GetDescendants()) do
                if v:IsA("BasePart") or v:IsA("Decal") then
                    v.Transparency = state and 0.7 or 0
                end
            end
        end
    end)
end

-- БАЗОВЫЕ ФУНКЦИИ (ВСЕМ)
AddToggle("Speed (100)", function(s) lp.Character.Humanoid.WalkSpeed = s and 100 or 16 end)
AddToggle("Fly", function(s) vars.fly = s end) -- (Добавь логику Fly из прошлых версий здесь)

-- ПОЛЕ ВВОДА КЛЮЧА
local KeyInput = Instance.new("TextBox", Main)
KeyInput.Size = UDim2.new(0, 240, 0, 35)
KeyInput.Position = UDim2.new(0.5, -120, 1, -45)
KeyInput.PlaceholderText = "Введите Ультра-Код..."
KeyInput.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
KeyInput.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", KeyInput)

KeyInput.FocusLost:Connect(function()
    local entered = KeyInput.Text
    for _, key in pairs(PremiumKeys) do
        if entered == key then
            KeyInput.Text = "ДОБРО ПОЖАЛОВАТЬ!"
            KeyInput.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
            UnlockUltra(entered)
            task.wait(2)
            KeyInput:Destroy()
            return
        end
    end
    KeyInput.Text = "НЕВЕРНЫЙ КОД"
    task.wait(1)
    KeyInput.Text = ""
end)

-- КНОПКА Z
local OpenBtn = Instance.new("TextButton", ScreenGui)
OpenBtn.Size = UDim2.new(0, 45, 0, 45)
OpenBtn.Position = UDim2.new(0, 10, 0.5, -22)
OpenBtn.Text = "Z"
OpenBtn.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
OpenBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", OpenBtn).CornerRadius = UDim.new(1, 0)
OpenBtn.MouseButton1Click:Connect(function() Main.Visible = not Main.Visible end)
