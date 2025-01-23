-- Load UI Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Redz Hub - Custom", "DarkTheme")

-- Create Logo Button (Small) - Top Left Corner
local logoButton = Instance.new("ImageButton")
logoButton.Parent = game.CoreGui:FindFirstChild("Redz Hub - Custom") or game.Players.LocalPlayer.PlayerGui:FindFirstChild("Redz Hub - Custom")
logoButton.Size = UDim2.new(0, 40, 0, 40) -- Smaller Logo
logoButton.Position = UDim2.new(0, 10, 0, 10) -- Top-Left Corner
logoButton.BackgroundTransparency = 1
logoButton.Image = "rbxassetid://140432928117878" -- Logo ID

-- Toggle UI Visibility
local isVisible = true
logoButton.MouseButton1Click:Connect(function()
    isVisible = not isVisible
    Window:ToggleUI(isVisible)
end)

-- Define States for Features
local States = {}

-- Create Tabs
local FarmTab = Window:NewTab("Farm")
local TeleportTab = Window:NewTab("Teleport")
local VisualTab = Window:NewTab("Visual")
local StatsTab = Window:NewTab("Stats")
local FruitRaidTab = Window:NewTab("Fruit/Raid")
local ChestTab = Window:NewTab("Chest")
local MiscTab = Window:NewTab("Misc")

--------------------
-- 📌 FARM MENU
--------------------
local FarmSection = FarmTab:NewSection("Auto Farm")

States.AutoFarmLevel = false
States.AutoFarmNearest = false
States.AutoFarmBoss = false

FarmSection:NewToggle("Auto Farm Level", "Automatically farm level", function(state)
    States.AutoFarmLevel = state
    print("Auto Farm Level: " .. tostring(state))
end)

FarmSection:NewToggle("Auto Farm Nearest", "Automatically farm nearest enemies", function(state)
    States.AutoFarmNearest = state
    print("Auto Farm Nearest: " .. tostring(state))
end)

FarmSection:NewToggle("Auto Farm Boss", "Automatically farm bosses", function(state)
    States.AutoFarmBoss = state
    print("Auto Farm Boss: " .. tostring(state))
end)

--------------------
-- 📌 TELEPORT MENU
--------------------
local TeleportSection = TeleportTab:NewSection("Teleport")

TeleportSection:NewButton("Teleport to Starter Island", "Teleport to Starter Island", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, 10, 0)
    print("Teleported to Starter Island")
end)

TeleportSection:NewButton("Teleport to Marine Fortress", "Teleport to Marine Fortress", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1000, 10, 1000)
    print("Teleported to Marine Fortress")
end)

--------------------
-- 📌 VISUAL MENU (ESP & Aimbot)
--------------------
local VisualSection = VisualTab:NewSection("ESP & Aimbot")

States.ESP = false
States.Aimbot = false

VisualSection:NewToggle("Enable ESP", "See through walls", function(state)
    States.ESP = state
    print("ESP: " .. tostring(state))
end)

VisualSection:NewToggle("Enable Aimbot", "Auto aim at enemies", function(state)
    States.Aimbot = state
    print("Aimbot: " .. tostring(state))
end)

--------------------
-- 📌 STATS MENU (Auto Points)
--------------------
local StatsSection = StatsTab:NewSection("Auto Stats")

StatsSection:NewButton("Auto Increase Melee", "Automatically add points to Melee", function()
    print("Auto Increasing Melee Points")
end)

StatsSection:NewButton("Auto Increase Defense", "Automatically add points to Defense", function()
    print("Auto Increasing Defense Points")
end)

--------------------
-- 📌 FRUIT & RAID MENU
--------------------
local FruitRaidSection = FruitRaidTab:NewSection("Fruit & Raid")

FruitRaidSection:NewButton("Auto Collect Devil Fruit", "Automatically collect Devil Fruits", function()
    print("Auto Collecting Devil Fruit")
end)

FruitRaidSection:NewButton("Auto Raid Boss", "Automatically join Raid Boss", function()
    print("Auto Raiding Boss")
end)

--------------------
-- 📌 CHEST MENU (Auto Collect Chests)
--------------------
local ChestSection = ChestTab:NewSection("Auto Chest")

ChestSection:NewButton("Auto Collect Chests", "Automatically collect all chests", function()
    print("Auto Collecting Chests")
end)

--------------------
-- 📌 MISC MENU (Reset, Disable All)
--------------------
local MiscSection = MiscTab:NewSection("Misc Settings")

MiscSection:NewButton("Reset Character", "Reset your character", function()
    game.Players.LocalPlayer.Character.Humanoid.Health = 0
    print("Character Reset")
end)

MiscSection:NewButton("Disable All", "Disable all features", function()
    for key, _ in pairs(States) do
        States[key] = false
    end
    print("All functions disabled")
end)
