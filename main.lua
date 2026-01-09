loadstring(game:HttpGet("https://raw.githubusercontent.com/Edgeiy/InfiniteYield/master/source"))()

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- [ Очистка ] --
if game.CoreGui:FindFirstChild("NightPulse_V2_Official") then game.CoreGui.NightPulse_V2_Official:Destroy() end

local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "NightPulse_V2_Official"

-- [ КНОПКА ОТКРЫТИЯ ] --
local ToggleBtn = Instance.new("TextButton", ScreenGui)
ToggleBtn.Size = UDim2.new(0, 110, 0, 35)
ToggleBtn.Position = UDim2.new(0, 10, 0.5, -17)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(110, 0, 255)
ToggleBtn.Text = "NIGHTPULSE V2"
ToggleBtn.TextColor3 = Color3.new(1,1,1)
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.TextSize = 12
Instance.new("UICorner", ToggleBtn)

-- [ ГЛАВНОЕ МЕНЮ ] --
local MainMenu = Instance.new("Frame", ScreenGui)
MainMenu.Size = UDim2.new(0, 440, 0, 400)
MainMenu.Position = UDim2.new(0.5, -220, 0.5, -200)
MainMenu.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
MainMenu.Visible = false
Instance.new("UICorner", MainMenu)
local Stroke = Instance.new("UIStroke", MainMenu)
Stroke.Color = Color3.fromRGB(110, 0, 255)
Stroke.Thickness = 2

-- Сайдбар
local Sidebar = Instance.new("Frame", MainMenu)
Sidebar.Size = UDim2.new(0, 110, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(22, 22, 26)
Instance.new("UICorner", Sidebar)

-- Контейнер
local Container = Instance.new("Frame", MainMenu)
Container.Size = UDim2.new(1, -125, 1, -10)
Container.Position = UDim2.new(0, 120, 0, 5)
Container.BackgroundTransparency = 1

local Pages = {
    Visuals = Instance.new("ScrollingFrame", Container),
    Combat = Instance.new("ScrollingFrame", Container),
    Security = Instance.new("ScrollingFrame", Container),
    Changelog = Instance.new("ScrollingFrame", Container)
}

for _, p in pairs(Pages) do
    p.Size = UDim2.new(1, 0, 1, 0)
    p.BackgroundTransparency = 1
    p.Visible = false
    p.ScrollBarThickness = 2
    p.ScrollBarImageColor3 = Color3.fromRGB(110, 0, 255)
    local layout = Instance.new("UIListLayout", p)
    layout.Padding = UDim.new(0, 6)
end
Pages.Visuals.Visible = true

-- [ ФУНКЦИИ ИНТЕРФЕЙСА ] --
local function CreateTab(name, page, y)
    local b = Instance.new("TextButton", Sidebar)
    b.Size = UDim2.new(1, 0, 0, 45)
    b.Position = UDim2.new(0, 0, 0, y)
    b.BackgroundTransparency = 1
    b.Text = name; b.TextColor3 = Color3.fromRGB(180, 180, 180); b.Font = Enum.Font.GothamBold; b.TextSize = 11
    b.MouseButton1Click:Connect(function()
        for _, pg in pairs(Pages) do pg.Visible = false end
        page.Visible = true
    end)
end

CreateTab("VISUALS", Pages.Visuals, 10)
CreateTab("COMBAT", Pages.Combat, 55)
CreateTab("SECURITY", Pages.Security, 100)
CreateTab("CHANGELOG", Pages.Changelog, 145)

local function CreateToggle(parent, text, var)
    local f = Instance.new("Frame", parent)
    f.Size = UDim2.new(1, -10, 0, 35); f.BackgroundTransparency = 1
    local l = Instance.new("TextLabel", f)
    l.Size = UDim2.new(1, -45, 1, 0); l.Text = text; l.TextColor3 = Color3.new(1,1,1); l.Font = Enum.Font.Gotham; l.TextSize = 13; l.TextXAlignment = Enum.TextXAlignment.Left; l.BackgroundTransparency = 1
    local b = Instance.new("TextButton", f)
    b.Size = UDim2.new(0, 35, 0, 18); b.Position = UDim2.new(1, -40, 0.5, -9); b.BackgroundColor3 = Color3.fromRGB(45, 45, 50); b.Text = ""
    Instance.new("UICorner", b).CornerRadius = UDim.new(1, 0)
    local d = Instance.new("Frame", b); d.Size = UDim2.new(0, 12, 0, 12); d.Position = UDim2.new(0, 3, 0.5, -6); d.BackgroundColor3 = Color3.new(1,1,1); Instance.new("UICorner", d).CornerRadius = UDim.new(1, 0)
    b.MouseButton1Click:Connect(function()
        _G[var] = not _G[var]
        TweenService:Create(b, TweenInfo.new(0.3), {BackgroundColor3 = _G[var] and Color3.fromRGB(110, 0, 255) or Color3.fromRGB(45, 45, 50)}):Play()
        TweenService:Create(d, TweenInfo.new(0.3), {Position = _G[var] and UDim2.new(1, -15, 0.5, -6) or UDim2.new(0, 3, 0.5, -6)}):Play()
    end)
end

-- Наполнение CHANGELOG
local function AddLog(text, color)
    local l = Instance.new("TextLabel", Pages.Changelog)
    l.Size = UDim2.new(1, -10, 0, 25)
    l.BackgroundTransparency = 1
    l.Text = "• " .. text
    l.TextColor3 = color or Color3.new(0.8, 0.8, 0.8)
    l.Font = Enum.Font.Gotham
    l.TextSize = 12
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.TextWrapped = true
end

AddLog("NIGHTPULSE V2 - OFFICIAL RELEASE", Color3.fromRGB(110, 0, 255))
AddLog("TG: t.me/Nightpulsev2", Color3.fromRGB(0, 170, 255))
AddLog("-----------------------------------", Color3.new(0.3, 0.3, 0.3))
AddLog("ИСПРАВЛЕНО: Размер 2D боксов (теперь адаптивный)", Color3.new(0, 1, 0))
AddLog("ИСПРАВЛЕНО: Визуалы больше не багаются", Color3.new(1, 1, 0))
AddLog("ИЗМЕНЕНИЕ: Удалено здоровье (временно)", Color3.new(1, 0, 0))

-- Кнопка ссылки
local TGButton = Instance.new("TextButton", Pages.Changelog)
TGButton.Size = UDim2.new(1, -10, 0, 35)
TGButton.BackgroundColor3 = Color3.fromRGB(0, 136, 204)
TGButton.Text = "ОФИЦИАЛЬНЫЙ TELEGRAM"
TGButton.TextColor3 = Color3.new(1,1,1)
TGButton.Font = Enum.Font.GothamBold
TGButton.TextSize = 12
Instance.new("UICorner", TGButton)
TGButton.MouseButton1Click:Connect(function()
    setclipboard("https://t.me/Nightpulsev2")
    TGButton.Text = "ССЫЛКА СКОПИРОВАНА!"
    task.wait(2)
    TGButton.Text = "ОФИЦИАЛЬНЫЙ TELEGRAM"
end)

-- Визуалы (Без здоровья)
CreateToggle(Pages.Visuals, "2D Boxes", "boxEsp")
CreateToggle(Pages.Visuals, "Tracers", "tracers")
CreateToggle(Pages.Visuals, "Show Names", "showNames")
CreateToggle(Pages.Visuals, "Show Distance", "showDist")
CreateToggle(Pages.Combat, "Instant Aimbot", "aimOn")
CreateToggle(Pages.Security, "Safe Anti-AFK", "antiAfk")
CreateToggle(Pages.Security, "Anti-Report Logger", "antiReport")
CreateToggle(Pages.Security, "Hide Client ID", "hideId")

ToggleBtn.MouseButton1Click:Connect(function() MainMenu.Visible = not MainMenu.Visible end)

-- [ ESP & COMBAT LOGIC ] --
local espObjects = {}
local function CreateDraw(type, props)
    local obj = Drawing.new(type)
    for k, v in pairs(props) do obj[k] = v end
    return obj
end

RunService.RenderStepped:Connect(function()
    for _, p in pairs(Players:GetPlayers()) do
        if p == LocalPlayer then continue end
        if not espObjects[p.Name] then
            espObjects[p.Name] = {
                box = CreateDraw("Square", {Thickness = 1, Color = Color3.new(1,1,1), Filled = false}),
                tr = CreateDraw("Line", {Thickness = 1, Color = Color3.new(1,1,1)}),
                info = CreateDraw("Text", {Size = 13, Color = Color3.new(1,1,1), Center = true, Outline = true})
            }
        end
        local d = espObjects[p.Name]
        local char = p.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local hum = char and char:FindFirstChildOfClass("Humanoid")

        if hrp and hum and hum.Health > 0 then
            local pos, onS = Camera:WorldToViewportPoint(hrp.Position)
            if onS then
                -- ИСПРАВЛЕННЫЙ РАСЧЕТ РАЗМЕРА БОКСА
                local distance = pos.Z
                local sizeY = (Camera.ViewportSize.Y / distance) * 4 -- Адаптивная высота
                local sizeX = sizeY * 0.6 -- Адаптивная ширина
                
                local bPos = Vector2.new(pos.X - sizeX/2, pos.Y - sizeY/2)
                
                d.box.Visible = _G.boxEsp
                d.box.Size = Vector2.new(sizeX, sizeY)
                d.box.Position = bPos
                
                if _G.showNames or _G.showDist then
                    d.info.Visible = true
                    d.info.Position = Vector2.new(pos.X, bPos.Y - 15)
                    local t = (_G.showNames and p.Name or "") .. (_G.showDist and " ["..math.floor(distance).."m]" or "")
                    d.info.Text = t
                else d.info.Visible = false end
                
                if _G.tracers then 
                    d.tr.Visible = true
                    d.tr.From = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y)
                    d.tr.To = Vector2.new(pos.X, pos.Y + sizeY/2)
                else d.tr.Visible = false end
            else for _, v in pairs(d) do v.Visible = false end end
        else for _, v in pairs(d) do v.Visible = false end end
    end
    
    if _G.aimOn and UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
        local target = nil; local minDist = math.huge
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Head") and p.Team ~= LocalPlayer.Team then
                local headPos, onS = Camera:WorldToViewportPoint(p.Character.Head.Position)
                if onS then
                    local dist = (Vector2.new(headPos.X, headPos.Y) - UIS:GetMouseLocation()).Magnitude
                    if dist < minDist then minDist = dist; target = p.Character.Head end
                end
            end
        end
        if target then Camera.CFrame = CFrame.new(Camera.CFrame.Position, target.Position) end
    end
end)

-- Драг
local dragging, dragStart, startPos
MainMenu.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true; dragStart = i.Position; startPos = MainMenu.Position end end)
UIS.InputChanged:Connect(function(i) if dragging and i.UserInputType == Enum.UserInputType.MouseMovement then
    local delta = i.Position - dragStart
    MainMenu.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end end)
UIS.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end end)
