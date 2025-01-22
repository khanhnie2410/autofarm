-- Services
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer
local hrp

-- Check if 'HumanoidRootPart' exists
local function waitForCharacter()
    while not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") do
        wait(0.1)
    end
    return player.Character:WaitForChild("HumanoidRootPart")
end

hrp = waitForCharacter()

-- Initial settings
local settings = {
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
    infiniteStamina = false,
    fastAttack = false,
    autoFarmBoss = false,
    teleportToNPC = false,
    attackType = "Melee", -- New attack type setting (Melee, Sword, Fruit, Gun)
}

-- Anti-AFK function
local function antiAFK()
    while settings.antiAFK do
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())  -- Simulate random action to avoid AFK
        wait(60)
    end
end

-- Auto Farm Logic
local function autoFarm()
    while settings.autoFarm do
        for _, npc in pairs(Workspace.Enemies:GetChildren()) do
            if npc:FindFirstChild("Humanoid") and npc.Humanoid.Health > 0 then
                hrp.CFrame = npc.HumanoidRootPart.CFrame  -- Move to NPC and attack
                ReplicatedStorage.Combat:FireServer("Attack")
                wait(settings.farmSpeed)
            end
        end
        wait(2)
    end
end

-- Auto Quest Logic
local function autoQuest()
    while settings.autoQuest do
        -- Logic to complete quests automatically here
        -- Example: check if the quest is active and perform required actions
        wait(2)
    end
end

-- Auto Respawn Logic
local function autoRespawn()
    while settings.autoRespawn do
        if not player.Character or not player.Character:FindFirstChild("Humanoid") or player.Character.Humanoid.Health <= 0 then
            -- Automatically respawn when dead
            ReplicatedStorage.Remotes.Respawn:FireServer()
        end
        wait(1)
    end
end

-- Auto Attack NPC
local function autoAttackNPC()
    while settings.autoAttackNPC do
        for _, npc in pairs(Workspace.Enemies:GetChildren()) do
            if npc:FindFirstChild("Humanoid") and npc.Humanoid.Health > 0 then
                -- Check attack type
                if settings.attackType == "Melee" then
                    ReplicatedStorage.Combat:FireServer("MeleeAttack")
                elseif settings.attackType == "Sword" then
                    ReplicatedStorage.Combat:FireServer("SwordAttack")
                elseif settings.attackType == "Fruit" then
                    ReplicatedStorage.Combat:FireServer("FruitAttack")
                elseif settings.attackType == "Gun" then
                    ReplicatedStorage.Combat:FireServer("GunAttack")
                end
                wait(settings.farmSpeed)
            end
        end
        wait(2)
    end
end

-- Create Menu
local function createMenu()
    local ScreenGui = Instance.new("ScreenGui", player.PlayerGui)
    local MainButton = Instance.new("ImageButton", ScreenGui)
    MainButton.Name = "MenuButton"
    MainButton.Size = UDim2.new(0, 50, 0, 50)
    MainButton.Position = UDim2.new(0.5, -25, 0, 10)
    MainButton.Image = "rbxassetid://140432928117878"
    MainButton.BackgroundTransparency = 1

    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.Size = UDim2.new(0, 400, 0, 500)
    MainFrame.Position = UDim2.new(0.5, -200, 0.5, -250)
    MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    MainFrame.Visible = false
    MainFrame.BorderSizePixel = 0

    MainButton.MouseButton1Click:Connect(function()
        MainFrame.Visible = not MainFrame.Visible
    end)

    -- Function to create a collapsible menu category
    local function createCategory(parent, categoryName, options)
        local categoryFrame = Instance.new("Frame", parent)
        categoryFrame.Size = UDim2.new(1, 0, 0, 30)
        categoryFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        categoryFrame.BorderSizePixel = 0

        local titleButton = Instance.new("TextButton", categoryFrame)
        titleButton.Size = UDim2.new(1, 0, 1, 0)
        titleButton.Text = categoryName
        titleButton.TextColor3 = Color3.new(1, 1, 1)
        titleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        titleButton.Font = Enum.Font.SourceSansBold
        titleButton.TextSize = 16

        local optionsFrame = Instance.new("Frame", parent)
        optionsFrame.Size = UDim2.new(1, 0, 0, #options * 35)
        optionsFrame.Position = UDim2.new(0, 0, 0, 30)
        optionsFrame.BackgroundTransparency = 1
        optionsFrame.Visible = false

        for i, option in ipairs(options) do
            local Button = Instance.new("TextButton", optionsFrame)
            Button.Size = UDim2.new(1, -10, 0, 30)
            Button.Position = UDim2.new(0, 5, 0, (i - 1) * 35)
            Button.Text = option
            Button.TextColor3 = Color3.new(1, 1, 1)
            Button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            Button.Font = Enum.Font.SourceSans
            Button.TextSize = 14

            Button.MouseButton1Click:Connect(function()
                settings[option] = not settings[option]
                Button.Text = option .. ": " .. (settings[option] and "ON" or "OFF")
            end)
        end

        titleButton.MouseButton1Click:Connect(function()
            optionsFrame.Visible = not optionsFrame.Visible
            categoryFrame.Size = UDim2.new(1, 0, 0, optionsFrame.Visible and (#options * 35 + 30) or 30)
        end)
    end

    createCategory(MainFrame, "Farm", {"autoFarm", "autoFarmBoss", "autoChest", "farmSpeed", "randomDelay", "minDelay", "maxDelay"})
    createCategory(MainFrame, "Combat", {"godMode", "autoAttackNPC", "fastAttack", "teleportToNPC"})
    createCategory(MainFrame, "Utility", {"autoRespawn", "antiAFK", "teleportEnabled", "autoFly", "flySpeed", "flyHeight"})
    createCategory(MainFrame, "Stats", {"autoLevelUp", "autoBuyItems", "autoQuest", "autoFruit"})
    createCategory(MainFrame, "Race", {"raceType", "v2QuestComplete", "v3QuestComplete", "v4QuestComplete"})
    createCategory(MainFrame, "Miscellaneous", {"menuEnabled", "infiniteStamina"})
end

-- Initialize Menu and functions
createMenu()
spawn(antiAFK)
spawn(autoFarm)
spawn(autoQuest)
spawn(autoRespawn)
spawn(autoAttackNPC)

print("Script initialized successfully!")
