local plr = game:GetService("Players").LocalPlayer

getgenv().Anti = true
getgenv().KillAura = false

local Anti
Anti = hookmetamethod(game, "__namecall", function(self, ...)
        if self == plr and getnamecallmethod():lower() == "kick" and getgenv().Anti then
            return warn("[ANTI-KICK] Client Tried To Call Kick Function On LocalPlayer")
        end
        return Anti(self, ...)
    end)

local ScreenGui = Instance.new("ScreenGui", game.Players.LocalPlayer.PlayerGui)
ScreenGui.Parent = game:GetService("CoreGui")

local ToggleButton = Instance.new("TextButton", ScreenGui)
ToggleButton.Size = UDim2.new(0, 50, 0, 50)
ToggleButton.Position = UDim2.new(0, 15, 0, 15)
ToggleButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
ToggleButton.Text = "+"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.TextSize = 24
ToggleButton.BorderSizePixel = 0

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 220, 0, 340)
Frame.Position = UDim2.new(0, 15, 0, 70)
Frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Frame.BorderSizePixel = 0
Frame.Visible = false

local FrameDupe = Instance.new("Frame", ScreenGui)
FrameDupe.Size = UDim2.new(0, 200, 0, 320)
FrameDupe.Position = UDim2.new(0, 290, 0, 70)
FrameDupe.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
FrameDupe.BorderSizePixel = 0
FrameDupe.Visible = false

local FrameCombat = Instance.new("Frame", ScreenGui)
FrameCombat.Size = UDim2.new(0, 200, 0, 320)
FrameCombat.Position = UDim2.new(0, 565, 0, 70)
FrameCombat.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
FrameCombat.BorderSizePixel = 0
FrameCombat.Visible = false

local UICorner = Instance.new("UICorner", Frame)
UICorner.CornerRadius = UDim.new(0, 10)
local UICorner = Instance.new("UICorner", Header)
UICorner.CornerRadius = UDim.new(0, 10)
local UICorner = Instance.new("UICorner", FrameDupe)
UICorner.CornerRadius = UDim.new(0, 10)
local UICorner = Instance.new("UICorner", HeaderDupe)
UICorner.CornerRadius = UDim.new(0, 10)
local UICorner = Instance.new("UICorner", FrameCombat)
UICorner.CornerRadius = UDim.new(0, 10)
local UICorner = Instance.new("UICorner", HeaderCombat)
UICorner.CornerRadius = UDim.new(0, 10)

local ScrollingFrame = Instance.new("ScrollingFrame", Frame)
ScrollingFrame.Size = UDim2.new(1, -20, 1, -40)
ScrollingFrame.Position = UDim2.new(0, 10, 0, 50)
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollingFrame.BackgroundTransparency = 1
ScrollingFrame.ScrollBarThickness = 8
ScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(150, 150, 150)

local Header = Instance.new("TextLabel", Frame)
Header.Text = "Ore ESP Settings"
Header.Size = UDim2.new(1, 0, 0, 50)
Header.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Header.TextColor3 = Color3.fromRGB(255, 255, 255)
Header.Font = Enum.Font.GothamBold
Header.TextSize = 14
Header.BorderSizePixel = 0

local HeaderDupe = Instance.new("TextLabel", FrameDupe)
HeaderDupe.Text = "Dupe"
HeaderDupe.Size = UDim2.new(1, 0, 0, 50)
HeaderDupe.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
HeaderDupe.TextColor3 = Color3.fromRGB(255, 255, 255)
HeaderDupe.Font = Enum.Font.GothamBold
HeaderDupe.TextSize = 14
HeaderDupe.BorderSizePixel = 0

local HeaderCombat = Instance.new("TextLabel", FrameCombat)
HeaderCombat.Text = "Combat"
HeaderCombat.Size = UDim2.new(1, 0, 0, 50)
HeaderCombat.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
HeaderCombat.TextColor3 = Color3.fromRGB(255, 255, 255)
HeaderCombat.Font = Enum.Font.GothamBold
HeaderCombat.TextSize = 14
HeaderCombat.BorderSizePixel = 0

local OthersHeader = Instance.new("TextLabel", FrameDupe)
OthersHeader.Text = "Others"
OthersHeader.Size = UDim2.new(1, 0, 0, 50)
OthersHeader.Position = UDim2.new(0, 0, 0, 175) 
OthersHeader.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
OthersHeader.TextColor3 = Color3.fromRGB(255, 255, 255)
OthersHeader.Font = Enum.Font.GothamBold
OthersHeader.TextSize = 14
OthersHeader.BorderSizePixel = 0

local dragging, dragStart, startPos

local function makeDraggable(gui)
    gui.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = gui.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    gui.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

-- Make all frames and UI elements draggable
makeDraggable(Frame)
makeDraggable(FrameDupe)
makeDraggable(FrameCombat)
makeDraggable(ToggleButton)

local visibility = {
    CoalOre = true,
    SteelOre = true,
    GoldOre = true,
    DiamondOre = true,
    RubyOre = true,
    SapphireOre = true,
    EmeraldOre = true,
}

local wlist = {"CoalOre", "SteelOre", "GoldOre", "DiamondOre", "RubyOre", "SapphireOre", "EmeraldOre"}
local colors = {
    Color3.fromRGB(80, 80, 80), -- Coal
    Color3.fromRGB(192, 192, 192), -- Steel
    Color3.fromRGB(255, 223, 0), -- Gold
    Color3.fromRGB(0, 191, 255), -- Diamond
    Color3.fromRGB(255, 69, 0), -- Ruby
    Color3.fromRGB(75, 0, 130), -- Sapphire
    Color3.fromRGB(0, 255, 0), -- Emerald
}

local oreBoxes = {}

local lastUpdate = 0
local updateInterval = 1

local function updateESP()
    local currentTime = tick()
    if currentTime - lastUpdate < updateInterval then
        return
    end

    lastUpdate = currentTime

    for _, ore in ipairs(game.Workspace.Blocks:GetDescendants()) do
        if not ore:IsA("BasePart") then
            continue
        end

        if table.find(wlist, ore.Name) then
            local oreIndex = table.find(wlist, ore.Name)

            local existingESP = ore:FindFirstChild("ESP")
            if visibility[ore.Name] then
                if not existingESP then
                    local Box = Instance.new("BoxHandleAdornment")
                    Box.Name = "ESP"
                    Box.Size = ore.Size
                    Box.Adornee = ore
                    Box.AlwaysOnTop = true
                    Box.ZIndex = 10
                    Box.Transparency = 0.69
                    Box.Color3 = colors[oreIndex]
                    Box.Parent = ore
                    oreBoxes[ore] = Box
                else
                    existingESP.Color3 = colors[oreIndex]
                    existingESP.Size = ore.Size 
                end
            else
                if existingESP then
                    existingESP:Destroy()
                    oreBoxes[ore] = nil
                end
            end
        end
    end
end

game.Workspace.Blocks.DescendantAdded:Connect(function(descendant)
    if table.find(wlist, descendant.Name) then
        wait(1)
        updateESP()
    end
end)

game.Workspace.Blocks.DescendantRemoving:Connect(function(descendant)
    if descendant:FindFirstChild("ESP") then
        descendant.ESP:Destroy()
        oreBoxes[descendant] = nil
    end
end)

local function updateESPAsync()
    coroutine.wrap(function()
        wait(1)
        updateESP()
    end)()
end

game:GetService("RunService").Heartbeat:Connect(updateESPAsync)

local function updateUI()
    for index, oreName in ipairs(wlist) do
        local Button = ScrollingFrame:FindFirstChild(oreName)
        if Button then
            Button.Text = visibility[oreName] and oreName or oreName .. " (Hidden)"
        end
    end
end

function KillAura()
    while getgenv().KillAura do
        for _, player in pairs(game.Players:GetPlayers()) do
            if player ~= game.Players.LocalPlayer and player.Character then
                local targetRoot = player.Character:FindFirstChild("HumanoidRootPart")
                if targetRoot and game.Players.LocalPlayer:DistanceFromCharacter(targetRoot.Position) < 16 then
                    game.ReplicatedStorage.GameRemotes.Attack:InvokeServer(player.Character)
                end
            end
        end
        task.wait()
    end
end
  
for index, oreName in ipairs(wlist) do
    local Button = Instance.new("TextButton", ScrollingFrame)
    Button.Text = oreName
    Button.Size = UDim2.new(1, -10, 0, 30)
    Button.Position = UDim2.new(0, 5, 0, (index - 1) * 40)
    Button.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.Font = Enum.Font.Gotham
    Button.TextSize = 14
    Button.BorderSizePixel = 0

    Button.MouseButton1Click:Connect(function()
        visibility[oreName] = not visibility[oreName]
        Button.BackgroundColor3 = visibility[oreName] and Color3.fromRGB(100, 100, 100) or Color3.fromRGB(150, 0, 0)
        updateESP()
    end)
end

ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, #wlist * 40)

local InfiniteItemsButton = Instance.new("TextButton", FrameDupe)
InfiniteItemsButton.Text = "Infinite Items"
InfiniteItemsButton.Size = UDim2.new(1, -10, 0, 30)
InfiniteItemsButton.Position = UDim2.new(0, 5, 0, 50)
InfiniteItemsButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
InfiniteItemsButton.TextColor3 = Color3.fromRGB(255, 255, 255)
InfiniteItemsButton.Font = Enum.Font.Gotham
InfiniteItemsButton.TextSize = 16
InfiniteItemsButton.BorderSizePixel = 0

local ItemSelectLabel = Instance.new("TextLabel", FrameDupe)
ItemSelectLabel.Text = "Select an item first to make infinite items"
ItemSelectLabel.Size = UDim2.new(1, -10, 0, 20)
ItemSelectLabel.Position = UDim2.new(0, 5, 0, 85)
ItemSelectLabel.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ItemSelectLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
ItemSelectLabel.Font = Enum.Font.Gotham
ItemSelectLabel.TextSize = 12
ItemSelectLabel.BorderSizePixel = 0

local DSItemsButton = Instance.new("TextButton", FrameDupe)
DSItemsButton.Text = "Dupe Selected Items"
DSItemsButton.Size = UDim2.new(1, -10, 0, 30)
DSItemsButton.Position = UDim2.new(0, 5, 0, 100)
DSItemsButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
DSItemsButton.TextColor3 = Color3.fromRGB(255, 255, 255)
DSItemsButton.Font = Enum.Font.Gotham
DSItemsButton.TextSize = 14
DSItemsButton.BorderSizePixel = 0

local DEItemsButton = Instance.new("TextButton", FrameDupe)
DEItemsButton.Text = "Dupe Entire Chest"
DEItemsButton.Size = UDim2.new(1, -10, 0, 30)
DEItemsButton.Position = UDim2.new(0, 5, 0, 140)
DEItemsButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
DEItemsButton.TextColor3 = Color3.fromRGB(255, 255, 255)
DEItemsButton.Font = Enum.Font.Gotham
DEItemsButton.TextSize = 14
DEItemsButton.BorderSizePixel = 0

local FixLagButton = Instance.new("TextButton", FrameDupe)
FixLagButton.Text = "Fix Lag"
FixLagButton.Size = UDim2.new(1, -10, 0, 30)
FixLagButton.Position = UDim2.new(0, 5, 0, 230)
FixLagButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
FixLagButton.TextColor3 = Color3.fromRGB(255, 255, 255)
FixLagButton.Font = Enum.Font.Gotham
FixLagButton.TextSize = 14
FixLagButton.BorderSizePixel = 0

DEItemsButton.MouseButton1Click:Connect(function()
   local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local GameRemotes = ReplicatedStorage:WaitForChild("GameRemotes")
	local sortitems = GameRemotes:FindFirstChild("SortItem") or GameRemotes:FindFirstChild("SortItems")
    for i = 36, 62 do
        task.spawn(function()
            sortitems:InvokeServer(i)
        end)
    end
end)

InfiniteItemsButton.MouseButton1Click:Connect(function()
    local gameremotes = game:GetService("ReplicatedStorage").GameRemotes
local moveitems = gameremotes:FindFirstChild("MoveItem") or gameremotes:FindFirstChild("MoveItems")
local sortitems = gameremotes:FindFirstChild("SortItem") or gameremotes:FindFirstChild("SortItems")
local usetables = false   
   
            local args = {
            [1] = -1,
            [2] = 0,
            [3] = true,
            [4] = -99e99+100
            }
            local args2 = {[1] = {}}
            if usetables then
                args2[1][1] = args[1]
                args2[1][2] = args[2]
                args2[1][3] = args[3]
                args2[1][4] = args[4]
                moveitems:InvokeServer(unpack(args2))
            else
                moveitems:InvokeServer(unpack(args))
            end
end)

DSItemsButton.MouseButton1Click:Connect(function()
    local gameremotes = game:GetService("ReplicatedStorage"):FindFirstChild("GameRemotes")
    local moveitems = gameremotes:FindFirstChild("MoveItem") or gameremotes:FindFirstChild("MoveItems")
    local slot = game:GetService("Players").LocalPlayer.PlayerGui.HUDGui.Inventory.Slots:FindFirstChild("Slot-1")
    local b = slot.SlotNA.Count
    local bCount = tonumber(b.Text)
    local howmuch = 64 - bCount
    local usetables = false
    local success, err = pcall(function()
        if usetables then
            moveitems:InvokeServer({[1] = -1, [2] = 82, [3] = true, [4] = -howmuch})
        else
            moveitems:InvokeServer(-1, 82, true, -howmuch)
        end
    end)
end)

FixLagButton.MouseButton1Click:Connect(function()
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local gameRemotes = ReplicatedStorage:FindFirstChild("GameRemotes")
    local playerGui = game.Players.LocalPlayer.PlayerGui
    local craftingBook = playerGui:FindFirstChild("HUDGui") and playerGui.HUDGui.Inventory:FindFirstChild("CraftingBook")
    if craftingBook then
        craftingBook:Destroy()
    end

    for _, particle in ipairs(game.Workspace:GetDescendants()) do
        if particle:IsA("ParticleEmitter") then
            particle.Enabled = false
        end
    end
end)

local KillAuraToggle = Instance.new("TextButton", FrameCombat)
KillAuraToggle.Text = "KillAura"
KillAuraToggle.Size = UDim2.new(1, -10, 0, 30)
KillAuraToggle.Position = UDim2.new(0, 5, 0, 60)
KillAuraToggle.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
KillAuraToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
KillAuraToggle.Font = Enum.Font.Gotham
KillAuraToggle.TextSize = 14
KillAuraToggle.BorderSizePixel = 0

local SprintToggle = Instance.new("TextButton", FrameCombat)
SprintToggle.Text = "Sprint"
SprintToggle.Size = UDim2.new(1, -10, 0, 30)
SprintToggle.Position = UDim2.new(0, 5, 0, 100)
SprintToggle.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
SprintToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
SprintToggle.Font = Enum.Font.Gotham
SprintToggle.TextSize = 14
SprintToggle.BorderSizePixel = 0

local NoFallButton = Instance.new("TextButton", FrameCombat)
NoFallButton.Text = "No Fall Damage"
NoFallButton.Size = UDim2.new(1, -10, 0, 30)
NoFallButton.Position = UDim2.new(0, 5, 0, 140)
NoFallButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
NoFallButton.TextColor3 = Color3.fromRGB(255, 255, 255)
NoFallButton.Font = Enum.Font.Gotham
NoFallButton.TextSize = 14
NoFallButton.BorderSizePixel = 0

local JumpToggle = Instance.new("TextButton", FrameCombat)
JumpToggle.Text = "JumpPower"
JumpToggle.Size = UDim2.new(1, -10, 0, 30)
JumpToggle.Position = UDim2.new(0, 5, 0, 180)
JumpToggle.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
JumpToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
JumpToggle.Font = Enum.Font.Gotham
JumpToggle.TextSize = 14
JumpToggle.BorderSizePixel = 0

local isKillAuraEnabled = false
local isSprintEnabled = false
local isNoFallEnabled = false
local isJumpEnabled = false

KillAuraToggle.MouseButton1Click:Connect(function()
    isKillAuraEnabled = not isKillAuraEnabled
    KillAuraToggle.BackgroundColor3 = isKillAuraEnabled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(100, 100, 100)
    getgenv().KillAura = isKillAuraEnabled
    if isKillAuraEnabled then
        KillAura()
    end
end)

SprintToggle.MouseButton1Click:Connect(function()
    isSprintEnabled = not isSprintEnabled
    SprintToggle.BackgroundColor3 = isSprintEnabled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(100, 100, 100)

    if isSprintEnabled then
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 20
    else
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
    end
end)

NoFallButton.MouseButton1Click:Connect(function()
    local GameRemotes = game.ReplicatedStorage:WaitForChild("GameRemotes")
local Demo = GameRemotes:FindFirstChild("Demo") or Workspace:FindFirstChild("Demo")

    isNoFallEnabled = not isNoFallEnabled
    NoFallButton.BackgroundColor3 = isNoFallEnabled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(100, 100, 100)

    if isNoFallEnabled then
      if Demo.Parent == GameRemotes then
        Demo.Parent = Workspace
      end
    else
      if Demo.Parent == Workspace then
        Demo.Parent = GameRemotes
      end
    end
end)

JumpToggle.MouseButton1Click:Connect(function()
     local humanoid = game.Players.LocalPlayer.Character:WaitForChild("Humanoid")
    isJumpEnabled = not isJumpEnabled
    JumpToggle.BackgroundColor3 = isJumpEnabled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(100, 100, 100)

    if isJumpEnabled then
    humanoid.UseJumpPower, humanoid.JumpPower = true, 40
    else
        humanoid.UseJumpPower, humanoid.JumpPower = true, 25
    end
end)

ToggleButton.MouseButton1Click:Connect(function()
    Frame.Visible = not Frame.Visible
    FrameDupe.Visible = not FrameDupe.Visible
    FrameCombat.Visible = not FrameCombat.Visible
    ToggleButton.Text = Frame.Visible and "-" or "+"
end)

while wait(2) do
    updateESP()
end
