-- Services
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer
local hrp

-- Check for the existence of 'HumanoidRootPart'
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
    buyItems = { "Sword", "Armor", "Fruit" }
}

-- Anti-AFK function
local function antiAFK()
    while settings.antiAFK do
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())  -- Prevent AFK by simulating a random action
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

-- Auto Respawn Logic
local function autoRespawn()
    while settings.autoRespawn do
        if not player.Character or not player.Character:FindFirstChild("Humanoid") or player.Character.Humanoid.Health <= 0 then
            -- Respawn automatically if dead
            ReplicatedStorage.Remotes.Respawn:FireServer()
        end
        wait(1)
    end
end

-- Teleport Logic
local function teleportToNPC()
    while settings.teleportToNPC do
        local targetNPC = Workspace.NPCs:GetChildren() -- Assuming NPCs are stored in a folder called "NPCs"
        for _, npc in pairs(targetNPC) do
            if npc:FindFirstChild("HumanoidRootPart") then
                hrp.CFrame = npc.HumanoidRootPart.CFrame
                wait(settings.farmSpeed)
            end
        end
        wait(1)
    end
end

-- Fly Logic
local function fly()
    while settings.autoFly do
        hrp.CFrame = hrp.CFrame + Vector3.new(0, settings.flyHeight, 0) -- Fly at a specific height
        wait(settings.flySpeed)
    end
end

-- God Mode Logic
local function godMode()
    while settings.godMode do
        if player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.Health = player.Character.Humanoid.MaxHealth -- Infinite health
        end
        wait(0.1)
    end
end

-- Menu Creation Function
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
        categoryFrame.Size = UDim2.new(0.4, 0, 1, 0)
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
        optionsFrame.Size = UDim2.new(0.6, 0, 1, 0)
        optionsFrame.Position = UDim2.new(0.4, 0, 0, 0)
        optionsFrame.BackgroundTransparency = 1
        optionsFrame.Visible = false

        -- Create buttons for options
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
            categoryFrame.Size = UDim2.new(0.4, 0, 1, optionsFrame.Visible and (#options * 35 + 30) or 30)
        end)
    end

    -- Create categories
    createCategory(MainFrame, "Farm", {"autoFarm", "autoFarmBoss", "autoChest", "farmSpeed", "randomDelay", "minDelay", "maxDelay"})
    createCategory(MainFrame, "Combat", {"godMode", "autoAttackNPC", "fastAttack", "teleportToNPC"})
    createCategory(MainFrame, "Utility", {"autoRespawn", "antiAFK", "teleportEnabled", "autoFly", "flySpeed", "flyHeight"})
    createCategory(MainFrame, "Stats", {"autoLevelUp", "autoBuyItems", "autoQuest", "autoFruit"})
    createCategory(MainFrame, "Race", {"raceType", "v2QuestComplete", "v3QuestComplete", "v4QuestComplete"})
    createCategory(MainFrame, "Miscellaneous", {"menuEnabled", "infiniteStamina"})
end

-- Initialize Menu and Functions
createMenu()
spawn(antiAFK)
spawn(autoFarm)
spawn(autoRespawn)
spawn(fly)
spawn(godMode)
spawn(teleportToNPC)

print("Script has been successfully initialized!")
