-- Fruit Shop items
local fruitShopItems = {
    "Gomu Gomu no Mi", "Mera Mera no Mi", "Goro Goro no Mi", "Pika Pika no Mi", "Hie Hie no Mi", 
    "Magu Magu no Mi", "Tori Tori no Mi", "Zushi Zushi no Mi", "Yami Yami no Mi", "Suna Suna no Mi", 
    "Bara Bara no Mi", "Kilo Kilo no Mi", "Hana Hana no Mi", "Bomu Bomu no Mi", "Rumble Rumble no Mi", 
    "Dragon Dragon no Mi", "Venom Venom no Mi"
}

-- Items available for purchase in the SHOP (Swords and Guns)
local shopItems = {
    -- Swords
    "Dark Blade", "Flame Sword", "True Triple Katana", "Cursed Dual Katana", "Cutlass", "Ice Sword", "Soul Guitar", 
    "Blade", "Shuriken", "Magma Blade", "Pirate Blade", "Venom Blade", "Dragon Slayer", "Sand Blade",
    
    -- Guns
    "Gun", "Elite Gun", "Sniper", "Flintlock", "Shotgun", "Pistol", 
    "M1 Garand", "Bazooka", "Laser Gun", "Rocket Launcher",

    -- Accessories
    "Angel Wings", "Demon Wings", "Advanced Haki (Mastery)"
}

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
    v4QuestComplete = false
}

-- Get HumanoidRootPart of the player character
local player = game.Players.LocalPlayer
local hrp = player.Character and player.Character:WaitForChild("HumanoidRootPart")
if not hrp then
    warn("HumanoidRootPart not found!")
end

-- Create the menu GUI
local function createMenu()
    local ScreenGui = Instance.new("ScreenGui", player.PlayerGui)
    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.Size = UDim2.new(0, 200, 0, 500)
    MainFrame.Position = UDim2.new(0, 10, 0, 10)
    MainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    MainFrame.BackgroundTransparency = 0.5
    MainFrame.Visible = settings.menuEnabled

    local functions = {
        "autoFarm", "autoFly", "autoFruit", "autoQuest", "autoRespawn",
        "godMode", "autoBuyItems", "teleportEnabled", "autoChest", "autoAttackNPC", "autoLevelUp", "antiAFK"
    }

    for i, feature in ipairs(functions) do
        local Button = Instance.new("TextButton", MainFrame)
        Button.Size = UDim2.new(0, 180, 0, 25)  -- Compact button height
        Button.Position = UDim2.new(0, 10, 0, (i - 1) * 30 + 10)
        Button.Text = feature
        Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        Button.TextColor3 = Color3.new(1, 1, 1)

        Button.MouseButton1Click:Connect(function()
            settings[feature] = not settings[feature]
            Button.Text = feature .. ": " .. (settings[feature] and "ON" or "OFF")
        end)
    end
end

-- Auto Collect Chest
local function autoCollectChest()
    while settings.autoChest do
        for _, chest in pairs(workspace:GetDescendants()) do
            if chest:IsA("Model") and chest.Name:match("Chest") then
                hrp.CFrame = chest.PrimaryPart.CFrame
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
                hrp.CFrame = npc.HumanoidRootPart.CFrame
                game:GetService("ReplicatedStorage").Combat:FireServer("Attack")
                wait(0.5)
            end
        end
    end
end

-- Auto Level Up
local function autoLevelUp()
    while settings.autoLevelUp do
        local quest = workspace.QuestGivers:FindFirstChild("QuestName") -- Replace with actual NPC quest name
        if quest then
            hrp.CFrame = quest.CFrame
            wait(1)
            print("Receiving quest")
            -- Add logic to accept and complete quests
        end
        wait(5)
    end
end

-- Anti AFK
local function antiAFK()
    while settings.antiAFK do
        game:GetService("VirtualUser"):CaptureController()
        game:GetService("VirtualUser"):ClickButton2(Vector2.new())
        wait(60)
    end
end

-- Auto Buy Fruits from Fruit Shop
local function autoBuyFruits()
    while settings.autoBuyItems do
        local fruitShop = workspace:FindFirstChild("Fruit Shop") -- Replace with correct Fruit Shop name
        if fruitShop then
            hrp.CFrame = fruitShop.PrimaryPart.CFrame
            wait(1)
            local randomFruit = fruitShopItems[math.random(1, #fruitShopItems)]
            print("Buying Devil Fruit: " .. randomFruit)

            -- Logic to buy fruit (Assuming there is an event to buy fruits in the game)
            -- Example: game:GetService("ReplicatedStorage").Shop:FireServer("Buy", randomFruit)

            wait(5)
        else
            print("Fruit Shop not found!")
        end
        wait(10)
    end
end

-- Start the features
local function startFeatures()
    spawn(function() if settings.autoChest then autoCollectChest() end end)
    spawn(function() if settings.autoAttackNPC then autoAttackNPC() end end)
    spawn(function() if settings.autoLevelUp then autoLevelUp() end end)
    spawn(function() if settings.antiAFK then antiAFK() end end)
    spawn(function() if settings.autoBuyItems then autoBuyFruits() end end)
end

-- Start the script
createMenu()
startFeatures()
print("Script has been successfully enabled!")
