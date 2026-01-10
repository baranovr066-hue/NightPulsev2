loadstring(game:HttpGet("https://raw.githubusercontent.com/Edgeiy/InfiniteYield/master/source"))()

local players = game:GetService("Players")
local runService = game:GetService("RunService")
local uis = game:GetService("UserInputService")
local tweenService = game:GetService("TweenService")
local localPlayer = players.LocalPlayer
local camera = workspace.CurrentCamera

_G.boxEsp = false
_G.tracers = false
_G.showNames = false
_G.showDist = false
_G.healthBar = false
_G.lookLines = false
_G.aimOn = false
_G.aimPart = "Head"
_G.themeColor = Color3.fromRGB(0, 255, 200)
_G.antiAfk = false
_G.streamMode = false
_G.rainbowUI = false
_G.menuKey = Enum.KeyCode.Insert

if game.CoreGui:FindFirstChild("NightPulse_V2_Official") then 
    game.CoreGui.NightPulse_V2_Official:Destroy() 
end

local screenGui = Instance.new("ScreenGui", game.CoreGui)
screenGui.Name = "NightPulse_V2_Official"
screenGui.IgnoreGuiInset = true

local toggleBtn = Instance.new("TextButton", screenGui)
toggleBtn.Size = UDim2.new(0, 120, 0, 35)
toggleBtn.Position = UDim2.new(0, 15, 0.5, -17)
toggleBtn.BackgroundColor3 = Color3.fromRGB(10, 10, 12)
toggleBtn.Text = "NIGHTPULSE"
toggleBtn.TextColor3 = _G.themeColor
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.TextSize = 13
local btnStroke = Instance.new("UIStroke", toggleBtn)
btnStroke.Color = _G.themeColor
btnStroke.Thickness = 1.5
Instance.new("UICorner", toggleBtn).CornerRadius = UDim.new(0, 4)

local mainMenu = Instance.new("Frame", screenGui)
mainMenu.Size = UDim2.new(0, 500, 0, 420)
mainMenu.Position = UDim2.new(0.5, -250, 0.5, -210)
mainMenu.BackgroundColor3 = Color3.fromRGB(12, 12, 14)
mainMenu.Visible = false
Instance.new("UICorner", mainMenu).CornerRadius = UDim.new(0, 6)
local mainStroke = Instance.new("UIStroke", mainMenu)
mainStroke.Color = _G.themeColor
mainStroke.Thickness = 1.2

local sidebar = Instance.new("Frame", mainMenu)
sidebar.Size = UDim2.new(0, 130, 1, 0)
sidebar.BackgroundColor3 = Color3.fromRGB(16, 16, 18)
Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0, 6)

local container = Instance.new("Frame", mainMenu)
container.Size = UDim2.new(1, -145, 1, -20)
container.Position = UDim2.new(0, 140, 0, 10)
container.BackgroundTransparency = 1

local pages = {
    visuals = Instance.new("ScrollingFrame", container),
    combat = Instance.new("ScrollingFrame", container),
    security = Instance.new("ScrollingFrame", container),
    settings = Instance.new("ScrollingFrame", container)
}

for _, p in pairs(pages) do
    p.Size = UDim2.new(1, 0, 1, 0)
    p.BackgroundTransparency = 1
    p.Visible = false
    p.ScrollBarThickness = 0
    p.CanvasSize = UDim2.new(0,0,1.5,0)
    local layout = Instance.new("UIListLayout", p)
    layout.Padding = UDim.new(0, 8)
end
pages.visuals.Visible = true

local function updateTheme(color)
    _G.themeColor = color
    mainStroke.Color = color
    btnStroke.Color = color
    toggleBtn.TextColor3 = color
end

runService.RenderStepped:Connect(function()
    if _G.rainbowUI then
        local hue = tick() % 5 / 5
        updateTheme(Color3.fromHSV(hue, 0.8, 1))
    end
end)

local function createTab(name, page, y)
    local b = Instance.new("TextButton", sidebar)
    b.Size = UDim2.new(0.9, 0, 0, 35)
    b.Position = UDim2.new(0.05, 0, 0, y)
    b.BackgroundTransparency = 1
    b.Text = name; b.TextColor3 = Color3.fromRGB(120, 120, 125); b.Font = Enum.Font.GothamBold; b.TextSize = 11; b.TextXAlignment = Enum.TextXAlignment.Left
    local pad = Instance.new("UIPadding", b); pad.PaddingLeft = UDim.new(0, 10)
    b.MouseButton1Click:Connect(function()
        for _, pg in pairs(pages) do pg.Visible = false end
        page.Visible = true
        for _, btn in pairs(sidebar:GetChildren()) do if btn:IsA("TextButton") then btn.TextColor3 = Color3.fromRGB(120, 120, 125) end end
        b.TextColor3 = _G.themeColor
    end)
end

createTab("VISUALS", pages.visuals, 20)
createTab("COMBAT", pages.combat, 60)
createTab("SECURITY", pages.security, 100)
createTab("SETTINGS", pages.settings, 140)

local function createToggle(parent, text, var)
    local f = Instance.new("Frame", parent)
    f.Size = UDim2.new(1, -10, 0, 40); f.BackgroundColor3 = Color3.fromRGB(20, 20, 23); Instance.new("UICorner", f)
    local l = Instance.new("TextLabel", f)
    l.Size = UDim2.new(1, -60, 1, 0); l.Position = UDim2.new(0, 10, 0, 0); l.Text = text; l.TextColor3 = Color3.new(0.9,0.9,0.9); l.Font = Enum.Font.Gotham; l.TextSize = 13; l.TextXAlignment = Enum.TextXAlignment.Left; l.BackgroundTransparency = 1
    local b = Instance.new("TextButton", f)
    b.Size = UDim2.new(0, 40, 0, 20); b.Position = UDim2.new(1, -50, 0.5, -10); b.BackgroundColor3 = Color3.fromRGB(35, 35, 40); b.Text = ""
    Instance.new("UICorner", b).CornerRadius = UDim.new(1, 0)
    local d = Instance.new("Frame", b); d.Size = UDim2.new(0, 14, 0, 14); d.Position = UDim2.new(0, 3, 0.5, -7); d.BackgroundColor3 = Color3.new(1,1,1); Instance.new("UICorner", d).CornerRadius = UDim.new(1, 0)
    b.MouseButton1Click:Connect(function()
        _G[var] = not _G[var]
        tweenService:Create(b, TweenInfo.new(0.2), {BackgroundColor3 = _G[var] and _G.themeColor or Color3.fromRGB(35, 35, 40)}):Play()
        tweenService:Create(d, TweenInfo.new(0.2), {Position = _G[var] and UDim2.new(1, -17, 0.5, -7) or UDim2.new(0, 3, 0.5, -7)}):Play()
        if var == "antiAfk" and _G.antiAfk then
             localPlayer.Idled:Connect(function() if _G.antiAfk then game:GetService("VirtualUser"):CaptureController(); game:GetService("VirtualUser"):ClickButton2(Vector2.new()) end end)
        end
    end)
end

local function createSelector(parent, text, options, var)
    local f = Instance.new("Frame", parent)
    f.Size = UDim2.new(1, -10, 0, 45); f.BackgroundColor3 = Color3.fromRGB(20, 20, 23); Instance.new("UICorner", f)
    local l = Instance.new("TextLabel", f)
    l.Size = UDim2.new(0.4, 0, 1, 0); l.Position = UDim2.new(0, 10, 0, 0); l.Text = text; l.TextColor3 = Color3.new(0.9,0.9,0.9); l.Font = Enum.Font.Gotham; l.TextSize = 13; l.TextXAlignment = Enum.TextXAlignment.Left; l.BackgroundTransparency = 1
    local container = Instance.new("Frame", f)
    container.Size = UDim2.new(0.6, -10, 0, 30); container.Position = UDim2.new(0.4, 5, 0.5, -15); container.BackgroundTransparency = 1
    local layout = Instance.new("UIListLayout", container); layout.FillDirection = Enum.FillDirection.Horizontal; layout.Padding = UDim.new(0, 5); layout.HorizontalAlignment = Enum.HorizontalAlignment.Right
    for _, opt in pairs(options) do
        local b = Instance.new("TextButton", container)
        b.Size = UDim2.new(0, 45, 1, 0); b.BackgroundColor3 = Color3.fromRGB(35, 35, 40); b.Text = opt.Name; b.TextColor3 = Color3.new(0.7,0.7,0.7); b.Font = Enum.Font.GothamBold; b.TextSize = 9; Instance.new("UICorner", b)
        b.MouseButton1Click:Connect(function()
            _G[var] = opt.Value
            for _, child in pairs(container:GetChildren()) do if child:IsA("TextButton") then child.TextColor3 = Color3.new(0.7,0.7,0.7); child.BackgroundColor3 = Color3.fromRGB(35, 35, 40) end end
            b.TextColor3 = _G.themeColor; b.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
        end)
    end
end

local function createKeybind(parent, text, var)
    local f = Instance.new("Frame", parent)
    f.Size = UDim2.new(1, -10, 0, 40); f.BackgroundColor3 = Color3.fromRGB(20, 20, 23); Instance.new("UICorner", f)
    local l = Instance.new("TextLabel", f)
    l.Size = UDim2.new(1, -100, 1, 0); l.Position = UDim2.new(0, 10, 0, 0); l.Text = text; l.TextColor3 = Color3.new(0.9,0.9,0.9); l.Font = Enum.Font.Gotham; l.TextSize = 13; l.TextXAlignment = Enum.TextXAlignment.Left; l.BackgroundTransparency = 1
    local b = Instance.new("TextButton", f)
    b.Size = UDim2.new(0, 80, 0, 25); b.Position = UDim2.new(1, -85, 0.5, -12); b.BackgroundColor3 = Color3.fromRGB(35, 35, 40); b.Text = _G[var].Name; b.TextColor3 = Color3.new(1,1,1); b.Font = Enum.Font.GothamBold; b.TextSize = 10; Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(function()
        b.Text = "..."; local connection
        connection = uis.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Keyboard then
                _G[var] = input.KeyCode; b.Text = input.KeyCode.Name; connection:Disconnect()
            end
        end)
    end)
end

createToggle(pages.visuals, "2D Boxes", "boxEsp")
createToggle(pages.visuals, "Health Bar", "healthBar")
createToggle(pages.visuals, "Looking Vector", "lookLines")
createToggle(pages.visuals, "Tracers", "tracers")
createToggle(pages.visuals, "Show Names", "showNames")
createToggle(pages.visuals, "Show Distance", "showDist")

createToggle(pages.combat, "Instant Auto-Aim", "aimOn")
createSelector(pages.combat, "Target Part", {{Name="HEAD", Value="Head"}, {Name="BODY", Value="UpperTorso"}, {Name="LEG", Value="LeftLowerLeg"}}, "aimPart")

createToggle(pages.security, "Anti-AFK Protection", "antiAfk")
createToggle(pages.security, "Streamer Mode", "streamMode")

createToggle(pages.settings, "Rainbow UI", "rainbowUI")
createKeybind(pages.settings, "Menu Toggle Key", "menuKey")

toggleBtn.MouseButton1Click:Connect(function() mainMenu.Visible = not mainMenu.Visible end)
uis.InputBegan:Connect(function(input, gpe) if not gpe and input.KeyCode == _G.menuKey then mainMenu.Visible = not mainMenu.Visible end end)

local espObjects = {}
local function createDraw(type, props)
    local obj = Drawing.new(type); for k, v in pairs(props) do obj[k] = v end; return obj
end

local function isVisible(part)
    local char = localPlayer.Character; if not char then return false end
    local params = RaycastParams.new(); params.FilterType = Enum.RaycastFilterType.Exclude; params.FilterDescendantsInstances = {char, screenGui}
    local result = workspace:Raycast(camera.CFrame.Position, (part.Position - camera.CFrame.Position).Unit * 1000, params)
    return (result and result.Instance:IsDescendantOf(part.Parent)) or result == nil
end

runService.RenderStepped:Connect(function()
    for _, p in pairs(players:GetPlayers()) do
        if p == localPlayer then continue end
        if not espObjects[p.Name] then
            espObjects[p.Name] = {
                box = createDraw("Square", {Thickness = 1, Filled = false, Visible = false}),
                healthBg = createDraw("Square", {Thickness = 1, Color = Color3.new(0,0,0), Filled = true, Visible = false}),
                healthBar = createDraw("Square", {Thickness = 1, Filled = true, Visible = false}),
                lookLine = createDraw("Line", {Thickness = 1.5, Color = Color3.new(1,1,1), Visible = false}),
                tr = createDraw("Line", {Thickness = 1, Visible = false}),
                info = createDraw("Text", {Size = 13, Color = Color3.new(1,1,1), Center = true, Outline = true, Visible = false})
            }
        end
        local d = espObjects[p.Name]
        local char = p.Character; local hrp = char and char:FindFirstChild("HumanoidRootPart"); local hum = char and char:FindFirstChildOfClass("Humanoid"); local head = char and char:FindFirstChild("Head")
        
        if hrp and hum and hum.Health > 0 then
            local pos, onS = camera:WorldToViewportPoint(hrp.Position)
            if onS then
                local dist = (camera.CFrame.Position - hrp.Position).Magnitude
                local sizeY = (camera.ViewportSize.Y / dist) * 3; local sizeX = sizeY * 1.5; local bPos = Vector2.new(pos.X - sizeX/2, pos.Y - sizeY/2)
                
                d.box.Visible = _G.boxEsp; d.box.Color = _G.themeColor; d.box.Size = Vector2.new(sizeX, sizeY); d.box.Position = bPos
                
                if _G.healthBar then
                    d.healthBg.Visible = true; d.healthBg.Size = Vector2.new(3, sizeY); d.healthBg.Position = Vector2.new(bPos.X - 5, bPos.Y)
                    d.healthBar.Visible = true; d.healthBar.Size = Vector2.new(2, (hum.Health/hum.MaxHealth) * sizeY)
                    d.healthBar.Position = Vector2.new(bPos.X - 5, bPos.Y + (sizeY - d.healthBar.Size.Y))
                    d.healthBar.Color = Color3.fromHSV((hum.Health/hum.MaxHealth) * 0.3, 1, 1)
                else d.healthBg.Visible = false; d.healthBar.Visible = false end

                if _G.lookLines and head then
                    local lookPos, lookOnS = camera:WorldToViewportPoint(head.Position + head.CFrame.LookVector * 6)
                    if lookOnS then
                        d.lookLine.Visible = true; d.lookLine.From = Vector2.new(pos.X, pos.Y - sizeY/2); d.lookLine.To = Vector2.new(lookPos.X, lookPos.Y); d.lookLine.Color = _G.themeColor
                    else d.lookLine.Visible = false end
                else d.lookLine.Visible = false end

                d.info.Visible = (_G.showNames or _G.showDist); d.info.Position = Vector2.new(pos.X, bPos.Y - 15)
                d.info.Text = (_G.showNames and (_G.streamMode and "Player" or p.Name) or "") .. (_G.showDist and " ["..math.floor(dist).."m]" or "")
                d.tr.Visible = _G.tracers; d.tr.Color = _G.themeColor; d.tr.From = Vector2.new(camera.ViewportSize.X/2, camera.ViewportSize.Y); d.tr.To = Vector2.new(pos.X, pos.Y + sizeY/2)
            else for _, v in pairs(d) do v.Visible = false end end
        else for _, v in pairs(d) do v.Visible = false end end
    end

    if _G.aimOn then
        local target = nil; local minDist = math.huge
        for _, p in pairs(players:GetPlayers()) do
            if p ~= localPlayer and p.Character and p.Character:FindFirstChildOfClass("Humanoid") and p.Character:FindFirstChildOfClass("Humanoid").Health > 0 then
                local part = p.Character:FindFirstChild(_G.aimPart) or p.Character:FindFirstChild("HumanoidRootPart")
                if part then
                    local partPos, onS = camera:WorldToViewportPoint(part.Position)
                    if onS and isVisible(part) then
                        local dist = (Vector2.new(partPos.X, partPos.Y) - Vector2.new(camera.ViewportSize.X/2, camera.ViewportSize.Y/2)).Magnitude
                        if dist < 400 and dist < minDist then minDist = dist; target = part end
                    end
                end
            end
        end
        if target then camera.CFrame = CFrame.new(camera.CFrame.Position, target.Position) end
    end
end)

local dragging, dragStart, startPos
mainMenu.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true; dragStart = i.Position; startPos = mainMenu.Position end end)
uis.InputChanged:Connect(function(i) if dragging and i.UserInputType == Enum.UserInputType.MouseMovement then
    local delta = i.Position - dragStart; mainMenu.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end end)
uis.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end end)
