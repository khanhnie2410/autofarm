local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local workspace = game:GetService("Workspace")

local player = Players.LocalPlayer
local hrp = player.Character and player.Character:WaitForChild("HumanoidRootPart")

if not hrp then
    warn("HumanoidRootPart not found!")
    return
end

-- Configuration for Features
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
    teleportToNPC = false
}

-- Function to prevent AFK
local function antiAFK()
    while settings.antiAFK do
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
        wait(60)
    end
end

-- Function to create the menu GUI
local function createMenu()
    local ScreenGui = Instance.new("ScreenGui", player.PlayerGui)
    local MainButton = Instance.new("ImageButton", ScreenGui)
    MainButton.Name = "MenuButton"
    MainButton.Size = UDim2.new(0, 50, 0, 50)
    MainButton.Position = UDim2.new(0, 10, 0, 10)
    MainButton.Image = "rbxassetid://140432928117878"
    MainButton.BackgroundTransparency = 1

    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.Size = UDim2.new(0, 300, 0, 400)
    MainFrame.Position = UDim2.new(0, 70, 0, 10)
    MainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    MainFrame.BackgroundTransparency = 0.5
    MainFrame.Visible = false

    MainButton.MouseButton1Click:Connect(function()
        MainFrame.Visible = not MainFrame.Visible
    end)

    local function createCategory(categoryName, options)
        local categoryFrame = Instance.new("Frame", MainFrame)
        categoryFrame.Size = UDim2.new(0, 280, 0, 50 + (#options * 30))
        categoryFrame.Position = UDim2.new(0, 10, 0, 10)
        categoryFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

        local titleLabel = Instance.new("TextLabel", categoryFrame)
        titleLabel.Size = UDim2.new(1, 0, 0, 30)
        titleLabel.Text = categoryName
        titleLabel.TextColor3 = Color3.new(1, 1, 1)
        titleLabel.BackgroundTransparency = 1

        for i, option in ipairs(options) do
            local Button = Instance.new("TextButton", categoryFrame)
            Button.Size = UDim2.new(1, -10, 0, 25)
            Button.Position = UDim2.new(0, 5, 0, 30 + (i - 1) * 30)
            Button.Text = option
            Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            Button.TextColor3 = Color3.new(1, 1, 1)

            Button.MouseButton1Click:Connect(function()
                settings[option] = not settings[option]
                Button.Text = option .. ": " .. (settings[option] and "ON" or "OFF")

                -- Logic to execute actions when a feature is toggled
                if option == "autoFarm" then
                    if settings.autoFarm then
                        spawn(autoFarmAction)
                    end
                elseif option == "autoFly" then
                    if settings.autoFly then
                        spawn(autoFlyAction)
                    end
                elseif option == "autoRespawn" then
                    if settings.autoRespawn then
                        spawn(autoRespawnAction)
                    end
                elseif option == "autoAttackNPC" then
                    if settings.autoAttackNPC then
                        spawn(autoAttackNPCAction)
                    end
                elseif option == "autoLevelUp" then
                    if settings.autoLevelUp then
                        spawn(autoLevelUpAction)
                    end
                elseif option == "godMode" then
                    if settings.godMode then
                        spawn(godModeAction)
                    end
                elseif option == "autoChest" then
                    if settings.autoChest then
                        spawn(autoChestAction)
                    end
                elseif option == "antiAFK" then
                    if settings.antiAFK then
                        spawn(antiAFKAction)
                    end
                end
            end)
        end
    end

    -- Create categories with options
    createCategory("General Settings", {
        "autoFarm",
        "autoFly",
        "autoFruit",
        "autoQuest",
        "autoRespawn",
        "godMode",
        "teleportEnabled",
        "antiAFK"
    })

    createCategory("Advanced Settings", {
        "autoBuyItems",
        "autoChest",
        "autoAttackNPC",
        "autoLevelUp",
        "fastAttack",
        "infiniteStamina",
        "autoFarmBoss",
        "teleportToNPC"
    })
end

-- Logic for Auto Farm
local function autoFarmAction()
    while settings.autoFarm do
        for _, npc in pairs(workspace.Enemies:GetChildren()) do
            if npc:FindFirstChild("Humanoid") and npc.Humanoid.Health > 0 then
                hrp.CFrame = npc.HumanoidRootPart.CFrame
                ReplicatedStorage.Combat:FireServer("Attack")
                wait(settings.farmSpeed)
            end
        end
        wait(2)
    end
end

-- Logic for Auto Fly
local function autoFlyAction()
    while settings.autoFly do
        hrp.CFrame = hrp.CFrame + Vector3.new(0, settings.flyHeight, 0)
        wait(1 / settings.flySpeed)
    end
end

-- Logic for Auto Respawn
local function autoRespawnAction()
    while settings.autoRespawn do
        if player.Character and not player.Character:FindFirstChild("HumanoidRootPart") then
            wait(5)
            player:LoadCharacter()
        end
        wait(5)
    end
end

-- Logic for God Mode
local function godModeAction()
    while settings.godMode do
        if player.Character then
            player.Character.Humanoid.Health = player.Character.Humanoid.MaxHealth
        end
        wait(1)
    end
end

-- Start the script
createMenu()
spawn(antiAFK)
spawn(autoFarmAction)
spawn(autoFlyAction)

print("Script has been successfully loaded!")
