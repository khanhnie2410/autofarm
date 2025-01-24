--// UI Library (Mobile Friendly)
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()
local Window = OrionLib:MakeWindow({Name = "BloxFruits Hub", HidePremium = false, SaveConfig = true, ConfigFolder = "BloxFruitsConfig"})

--// Create a table containing the status of the functions
local States = {}

--// Auto Farm Tab
local FarmTab = Window:MakeTab({Name = "Auto Farm", Icon = "rbxassetid://4483345998", PremiumOnly = false})
States.AutoFarm = false

FarmTab:AddToggle({
    Name = "Auto Farm Level",
    Default = false,
    Callback = function(state)
        States.AutoFarm = state
        if state then
            print("Auto Farm Level Enabled")
            -- Logic Auto Farm Level
        else
            print("Auto Farm Level Disabled")
        end
    end
})

FarmTab:AddToggle({
    Name = "Auto Farm Boss",
    Default = false,
    Callback = function(state)
        States.AutoFarmBoss = state
        if state then
            print("Auto Farm Boss Enabled")
            -- Logic Auto Farm Boss
        else
            print("Auto Farm Boss Disabled")
        end
    end
})

--// Teleport Tab
local TeleportTab = Window:MakeTab({Name = "Teleport", Icon = "rbxassetid://4483345998", PremiumOnly = false})

TeleportTab:AddButton({
    Name = "Teleport to Starter Island",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, 10, 0)
        print("Teleported to Starter Island")
    end
})

TeleportTab:AddButton({
    Name = "Teleport to Marine Fortress",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1000, 10, 1000)
        print("Teleported to Marine Fortress")
    end
})

--// ESP & Aimbot Tab
local VisualTab = Window:MakeTab({Name = "ESP & Aimbot", Icon = "rbxassetid://4483345998", PremiumOnly = false})

VisualTab:AddToggle({
    Name = "Enable ESP",
    Default = false,
    Callback = function(state)
        States.ESP = state
        if state then
            print("ESP Enabled")
            -- Logic ESP
        else
            print("ESP Disabled")
        end
    end
})

VisualTab:AddToggle({
    Name = "Enable Aimbot",
    Default = false,
    Callback = function(state)
        States.Aimbot = state
        if state then
            print("Aimbot Enabled")
            -- Logic Aimbot
        else
            print("Aimbot Disabled")
        end
    end
})

--// Auto Stats Tab
local StatsTab = Window:MakeTab({Name = "Auto Stats", Icon = "rbxassetid://4483345998", PremiumOnly = false})

StatsTab:AddButton({
    Name = "Auto Increase Melee",
    Callback = function()
        print("Auto Increasing Melee Points")
        -- Logic tăng điểm Melee
    end
})

StatsTab:AddButton({
    Name = "Auto Increase Defense",
    Callback = function()
        print("Auto Increasing Defense Points")
        -- Logic tăng điểm Defense
    end
})

--// Auto Chest Tab
local ChestTab = Window:MakeTab({Name = "Auto Chest", Icon = "rbxassetid://4483345998", PremiumOnly = false})

ChestTab:AddButton({
    Name = "Auto Collect Chests",
    Callback = function()
        print("Auto Collecting Chests")
        -- Logic tự động nhặt rương
    end
})

--// Misc Tab
local MiscTab = Window:MakeTab({Name = "Misc Settings", Icon = "rbxassetid://4483345998", PremiumOnly = false})

MiscTab:AddButton({
    Name = "Reset Character",
    Callback = function()
        game.Players.LocalPlayer.Character.Humanoid.Health = 0
        print("Character Reset")
    end
})

MiscTab:AddButton({
    Name = "Disable All",
    Callback = function()
        for key, _ in pairs(States) do
            States[key] = false
        end
        print("All functions disabled")
    end
})

--// Initialize UI
OrionLib:Init()
