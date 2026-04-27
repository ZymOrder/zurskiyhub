-- [[ ZURSKIY HUB: ULTIMATE EDITION (NO KEYS) ]] --

local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local lp = Players.LocalPlayer

local vars = {
    speed = 16,
    jump = 50,
    noclip = false,
    fly = false,
    infjump = false,
    antidie = false
}

-- ГЛАВНЫЙ ИНТЕРФЕЙС
local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 260, 0, 350)
Main.Position = UDim2.new(0.5, -130, 0.5, -175)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
Main.Active = true
Main.Draggable = true -- Перетаскивание
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 15)
local Stroke = Instance.new("UIStroke", Main)
Stroke.Color = Color3.fromRGB(138, 43, 226)
Stroke.Thickness = 2

-- Заголовок
local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 45)
Title.Text = "ZURSKIY HUB V3"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = "GothamBold"
Title.TextSize = 18
Title.BackgroundTransparency = 1

-- Скролл для функций
local Scroll = Instance.new("ScrollingFrame", Main)
Scroll.Size = UDim2.new(1, -10, 1, -55)
Scroll.Position = UDim2.new(0, 5, 0, 50)
Scroll.BackgroundTransparency = 1
Scroll.CanvasSize = UDim2.new(0, 0, 0, 700)
Scroll.ScrollBarThickness = 2
local Layout = Instance.new("UIListLayout", Scroll)
Layout.Padding = UDim.new(0, 5)
Layout.HorizontalAlignment = "Center"

-- Функция создания переключателей (Toggle)
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

-- Функция для простых кнопок (Actions)
local function AddAction(text, color, callback)
    local btn = Instance.new("TextButton", Scroll)
    btn.Size = UDim2.new(0, 230, 0, 35)
    btn.BackgroundColor3 = color or Color3.fromRGB(45, 45, 50)
    btn.Text = text
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = "GothamBold"
    Instance.new("UICorner", btn)
    btn.MouseButton1Click:Connect(callback)
end

-- === ФУНКЦИИ ИГРОКА ===

AddToggle("SpeedHack (100)", function(state)
    lp.Character.Humanoid.WalkSpeed = state and 100 or 16
end)

AddToggle("Infinite Jump", function(state)
    vars.infjump = state
end)

UIS.JumpRequest:Connect(function()
    if vars.infjump then lp.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping") end
end)

AddToggle("Noclip", function(state)
    vars.noclip = state
end)

RunService.Stepped:Connect(function()
    if vars.noclip and lp.Character then
        for _, v in pairs(lp.Character:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
    end
end)

AddToggle("Fly", function(state)
    vars.fly = state
    local hrp = lp.Character.HumanoidRootPart
    if state then
        local bv = Instance.new("BodyVelocity", hrp)
        bv.Name = "ZurskiyFly"
        bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        task.spawn(function()
            while vars.fly do
                bv.Velocity = workspace.CurrentCamera.CFrame.LookVector * 100
                task.wait()
            end
            bv:Destroy()
        end)
    else
        if hrp:FindFirstChild("ZurskiyFly") then hrp.ZurskiyFly:Destroy() end
    end
end)

-- === ВИЗУАЛЫ И МИР ===

AddToggle("ESP Chams", function(state)
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= lp and p.Character then
            if state then
                local h = Instance.new("Highlight", p.Character)
                h.Name = "ZurskiyESP"
                h.FillColor = Color3.fromRGB(138, 43, 226)
            else
                if p.Character:FindFirstChild("ZurskiyESP") then p.Character.ZurskiyESP:Destroy() end
            end
        end
    end
end)

AddToggle("FullBright", function(state)
    game.Lighting.Brightness = state and 2 or 1
    game.Lighting.ClockTime = state and 12 or 14
end)

-- === ИНСТРУМЕНТЫ ===

AddAction("Get Click TP Tool", Color3.fromRGB(0, 100, 200), function()
    local tool = Instance.new("Tool")
    tool.RequiresHandle = false
    tool.Name = "Zurskiy TP"
    tool.Activated:Connect(function()
        lp.Character.HumanoidRootPart.CFrame = CFrame.new(lp:GetMouse().Hit.p + Vector3.new(0, 3, 0))
    end)
    tool.Parent = lp.Backpack
end)

AddAction("FPS Booster", Color3.fromRGB(50, 150, 50), function()
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("DataModelMesh") or v:IsA("Texture") or v:IsA("Decal") then v.Transparency = 1 end
    end
end)

AddAction("Server Hop", Color3.fromRGB(100, 100, 100), function()
    local ts = game:GetService("TeleportService")
    ts:Teleport(game.PlaceId, lp)
end)

AddAction("Copy Telegram", Color3.fromRGB(0, 136, 204), function()
    setclipboard("https://t.me/ZurskiyHub")
end)

-- КНОПКА ОТКРЫТИЯ/ЗАКРЫТИЯ
local OpenBtn = Instance.new("TextButton", ScreenGui)
OpenBtn.Size = UDim2.new(0, 45, 0, 45)
OpenBtn.Position = UDim2.new(0, 10, 0.5, -22)
OpenBtn.Text = "Z"
OpenBtn.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
OpenBtn.TextColor3 = Color3.new(1,1,1)
OpenBtn.Font = "GothamBold"
Instance.new("UICorner", OpenBtn).CornerRadius = UDim.new(1, 0)

OpenBtn.MouseButton1Click:Connect(function()
    Main.Visible = not Main.Visible
end)

-- Anti-AFK Logic
lp.Idled:Connect(function()
    game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    task.wait(1)
    game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end)

print("Zurskiy Hub Loaded! Enjoy.")
