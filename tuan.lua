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

-- Logic for Auto Farm
local function autoFarm()
    while settings.autoFarm do
        for _, npc in pairs(workspace.Enemies:GetChildren()) do
            if npc:FindFirstChild("Humanoid") and npc.Humanoid.Health > 0 then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = npc.HumanoidRootPart.CFrame
                game:GetService("ReplicatedStorage").Combat:FireServer("Attack")
                wait(settings.farmSpeed)  -- Adjust farm speed
            end
        end
        wait(1)
    end
end

-- Logic for Auto Fly
local function autoFly()
    local flying = false
    local bodyVelocity = Instance.new("BodyVelocity")
    local bodyGyro = Instance.new("BodyGyro")
    bodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
    bodyGyro.MaxTorque = Vector3.new(4000, 4000, 4000)
    bodyGyro.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame

    while settings.autoFly do
        if not flying then
            flying = true
            bodyVelocity.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart
            bodyGyro.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart
            bodyVelocity.Velocity = Vector3.new(0, settings.flySpeed, 0)
            bodyGyro.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
        else
            game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0, settings.flySpeed, 0)
        end
        wait(0.5)
    end
    -- Stop flying if autoFly is disabled
    bodyVelocity:Destroy()
    bodyGyro:Destroy()
end

-- Logic for Auto Respawn
local function autoRespawn()
    while settings.autoRespawn do
        if game.Players.LocalPlayer.Character.Humanoid.Health <= 0 then
            game:GetService("ReplicatedStorage").Game:FireServer("Respawn")  -- Replace with correct respawn event if necessary
        end
        wait(5)
    end
end

-- Logic for God Mode (Invincibility)
local function godMode()
    while settings.godMode do
        game.Players.LocalPlayer.Character.Humanoid.Health = math.huge  -- Set health to infinite
        wait(1)
    end
end

-- Logic for Teleportation to NPCs
local function teleportToNPC()
    while settings.teleportToNPC do
        for _, npc in pairs(workspace.NPCs:GetChildren()) do
            if npc:FindFirstChild("HumanoidRootPart") then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = npc.HumanoidRootPart.CFrame
                wait(1)
            end
        end
        wait(5)
    end
end

-- Add more feature logic as needed (like autoFruit, antiAFK, etc.)

-- Start the features based on user settings
local function startFeatures()
    spawn(function() if settings.autoFarm then autoFarm() end end)
    spawn(function() if settings.autoFly then autoFly() end end)
    spawn(function() if settings.autoRespawn then autoRespawn() end end)
    spawn(function() if settings.godMode then godMode() end end)
    spawn(function() if settings.teleportToNPC then teleportToNPC() end end)
    -- Add more spawns for other features
end

-- Create the Menu GUI
local function createMenu()
    local player = game.Players.LocalPlayer
    local ScreenGui = Instance.new("ScreenGui", player.PlayerGui)
    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.Size = UDim2.new(0, 150, 0, 150)
    MainFrame.Position = UDim2.new(0, 10, 0, 10)
    MainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    MainFrame.BackgroundTransparency = 0.5
    MainFrame.Visible = settings.menuEnabled

    -- Create logo button
    local LogoButton = Instance.new("ImageButton", MainFrame)
    LogoButton.Size = UDim2.new(0, 120, 0, 120)
    LogoButton.Position = UDim2.new(0, 15, 0, 15)
    LogoButton.Image = "rbxassetid://140432928117878"  -- Use provided logo ID
    LogoButton.BackgroundTransparency = 1

    -- Toggle menu visibility when clicking logo
    LogoButton.MouseButton1Click:Connect(function()
        MainFrame.Visible = not MainFrame.Visible
    end)

    -- Create feature buttons
    local functions = {
        {"autoFarm", "Auto Farm"}, {"autoFly", "Auto Fly"}, {"autoFruit", "Auto Fruit"}, {"autoQuest", "Auto Quest"},
        {"autoRespawn", "Auto Respawn"}, {"godMode", "God Mode"}, {"autoBuyItems", "Auto Buy Items"}, {"autoChest", "Auto Chest"},
        {"autoAttackNPC", "Auto Attack NPC"}, {"autoLevelUp", "Auto Level Up"}, {"antiAFK", "Anti AFK"},
        {"infiniteStamina", "Infinite Stamina"}, {"fastAttack", "Fast Attack"}, {"autoFarmBoss", "Auto Farm Boss"},
        {"teleportToNPC", "Teleport to NPC"}
    }

    for i, feature in ipairs(functions) do
        local Button = Instance.new("TextButton", MainFrame)
        Button.Size = UDim2.new(0, 120, 0, 25)
        Button.Position = UDim2.new(0, 15, 0, (i * 30) + 40)
        Button.Text = feature[2]
        Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        Button.TextColor3 = Color3.new(1, 1, 1)

        Button.MouseButton1Click:Connect(function()
            settings[feature[1]] = not settings[feature[1]]
            Button.Text = feature[2] .. ": " .. (settings[feature[1]] and "ON" or "OFF")
        end)
    end
end

-- Start the script
createMenu()
startFeatures()
print("Script has been successfully enabled!")
