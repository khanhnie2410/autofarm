-- Configuration for Features
local settings = {
    -- Auto Features
    autoFarm = false,
    autoFly = false,
    autoFruit = false,
    autoQuest = false,
    autoRespawn = true,
    godMode = false,
    teleportEnabled = true,
    autoBuyItems = false,
    autoChest = false,
    autoAttackNPC = false,
    autoLevelUp = false,
    antiAFK = true,
    farmSpeed = 1,
    flySpeed = 50,
    flyHeight = 100,
    randomDelay = true,
    minDelay = 2,
    maxDelay = 4,
    menuEnabled = true,
    raceType = "Human",
    v2QuestComplete = false,
    v3QuestComplete = false,
    v4QuestComplete = false,
    infiniteStamina = false, -- Infinite Stamina
    fastAttack = false, -- Fast Attack
    autoFruit = false, -- Auto Fruit
    autoFarmBoss = false, -- Auto Farm Boss
    teleportToNPC = false -- Auto Teleport to NPC
}

-- Function to create GUI Menu
local function createMenu()
    local ScreenGui = Instance.new("ScreenGui", game.Players.LocalPlayer.PlayerGui)
    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.Size = UDim2.new(0, 250, 0, 600)
    MainFrame.Position = UDim2.new(0, 10, 0, 10)
    MainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    MainFrame.BackgroundTransparency = 0.5
    MainFrame.Visible = settings.menuEnabled

    local functions = {
        {"autoFarm", "Auto Farm"}, {"autoFly", "Auto Fly"}, {"autoFruit", "Auto Fruit"}, {"autoQuest", "Auto Quest"}, 
        {"autoRespawn", "Auto Respawn"}, {"godMode", "God Mode"}, {"autoBuyItems", "Auto Buy Items"}, {"autoChest", "Auto Chest"},
        {"autoAttackNPC", "Auto Attack NPC"}, {"autoLevelUp", "Auto Level Up"}, {"antiAFK", "Anti AFK"},
        {"infiniteStamina", "Infinite Stamina"}, {"fastAttack", "Fast Attack"}, {"autoFarmBoss", "Auto Farm Boss"},
        {"teleportToNPC", "Teleport to NPC"}
    }

    for i, feature in ipairs(functions) do
        local Button = Instance.new("TextButton", MainFrame)
        Button.Size = UDim2.new(0, 230, 0, 30)
        Button.Position = UDim2.new(0, 10, 0, (i - 1) * 40 + 10)
        Button.Text = feature[2]
        Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        Button.TextColor3 = Color3.new(1, 1, 1)

        Button.MouseButton1Click:Connect(function()
            settings[feature[1]] = not settings[feature[1]]
            Button.Text = feature[2] .. ": " .. (settings[feature[1]] and "ON" or "OFF")
        end)
    end
end

-- Auto Collect Chest
local function autoCollectChest()
    while settings.autoChest do
        for _, chest in pairs(workspace:GetDescendants()) do
            if chest:IsA("Model") and chest.Name:match("Chest") then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = chest.PrimaryPart.CFrame
                wait(1)
            end
        end
        wait(2)
    end
end

-- Auto Attack NPC
local function autoAttackNPC()
    while settings.autoAttackNPC do
        for _, npc in pairs(workspace.Enemies:GetChildren()) do
            if npc:FindFirstChild("Humanoid") and npc.Humanoid.Health > 0 then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = npc.HumanoidRootPart.CFrame
                game:GetService("ReplicatedStorage").Combat:FireServer("Attack")
                wait(0.5)
            end
        end
    end
end

-- Auto Farm
local function autoFarm()
    while settings.autoFarm do
        for _, npc in pairs(workspace.Enemies:GetChildren()) do
            if npc:FindFirstChild("Humanoid") and npc.Humanoid.Health > 0 then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = npc.HumanoidRootPart.CFrame
                wait(0.5)
                game:GetService("ReplicatedStorage").Combat:FireServer("Attack")
            end
        end
        wait(settings.farmSpeed)
    end
end

-- Auto Fruit
local function autoEatFruit()
    while settings.autoFruit do
        -- Logic for auto fruit (eating fruit automatically)
        wait(5)
    end
end

-- Infinite Stamina
local function infiniteStamina()
    while settings.infiniteStamina do
        -- Logic to prevent stamina from depleting
        wait(0.5)
    end
end

-- Fast Attack
local function fastAttack()
    while settings.fastAttack do
        -- Logic to speed up attack rate
        wait(0.2)
    end
end

-- Auto Respawn
local function autoRespawn()
    while settings.autoRespawn do
        -- Code to automatically respawn after death
        wait(2)
    end
end

-- Teleport to NPC
local function teleportToNPC()
    while settings.teleportToNPC do
        local npc = workspace:FindFirstChild("NPC_Name") -- Change to NPC name
        if npc then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = npc.CFrame
        end
        wait(5)
    end
end

-- Auto Buy Items
local function autoBuyItems()
    while settings.autoBuyItems do
        -- Logic to buy items from the shop
        wait(5)
    end
end

-- Start all the features
local function startFeatures()
    spawn(function() if settings.autoFarm then autoFarm() end end)
    spawn(function() if settings.autoFly then autoFly() end end)
    spawn(function() if settings.autoFruit then autoEatFruit() end end)
    spawn(function() if settings.autoQuest then autoQuest() end end)
    spawn(function() if settings.autoRespawn then autoRespawn() end end)
    spawn(function() if settings.godMode then godMode() end end)
    spawn(function() if settings.autoChest then autoCollectChest() end end)
    spawn(function() if settings.autoAttackNPC then autoAttackNPC() end end)
    spawn(function() if settings.autoLevelUp then autoLevelUp() end end)
    spawn(function() if settings.antiAFK then antiAFK() end end)
    spawn(function() if settings.infiniteStamina then infiniteStamina() end end)
    spawn(function() if settings.fastAttack then fastAttack() end end)
    spawn(function() if settings.teleportToNPC then teleportToNPC() end end)
    spawn(function() if settings.autoBuyItems then autoBuyItems() end end)
end

-- Start the script
createMenu()
startFeatures()
print("Script has been successfully enabled!")
