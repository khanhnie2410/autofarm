-- Các vật phẩm trong Fruit Shop
local fruitShopItems = {
    "Gomu Gomu no Mi", "Mera Mera no Mi", "Goro Goro no Mi", "Pika Pika no Mi", "Hie Hie no Mi", 
    "Magu Magu no Mi", "Tori Tori no Mi", "Zushi Zushi no Mi", "Yami Yami no Mi", "Suna Suna no Mi", 
    "Bara Bara no Mi", "Kilo Kilo no Mi", "Hana Hana no Mi", "Bomu Bomu no Mi", "Rumble Rumble no Mi", 
    "Dragon Dragon no Mi", "Venom Venom no Mi"
}

-- Các vật phẩm có thể mua trong SHOP (Kiếm và Súng)
local shopItems = {
    -- Kiếm
    "Dark Blade", "Flame Sword", "True Triple Katana", "Cursed Dual Katana", "Cutlass", "Ice Sword", "Soul Guitar", 
    "Blade", "Shuriken", "Magma Blade", "Pirate Blade", "Venom Blade", "Dragon Slayer", "Sand Blade",
    
    -- Súng
    "Gun", "Elite Gun", "Sniper", "Flintlock", "Shotgun", "Pistol", 
    "M1 Garand", "Bazooka", "Laser Gun", "Rocket Launcher",

    -- Phụ Kiện
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

-- Lấy HumanoidRootPart của nhân vật
local player = game.Players.LocalPlayer
local hrp = player.Character and player.Character:WaitForChild("HumanoidRootPart")
if not hrp then
    warn("Không tìm thấy HumanoidRootPart!")
end

-- Tạo menu GUI
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
        Button.Size = UDim2.new(0, 180, 0, 30)
        Button.Position = UDim2.new(0, 10, 0, (i - 1) * 35 + 10)
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
        local quest = workspace.QuestGivers:FindFirstChild("QuestName") -- Replace with real NPC quest name
        if quest then
            hrp.CFrame = quest.CFrame
            wait(1)
            print("Nhận nhiệm vụ")
            -- Thêm logic nhận và hoàn thành nhiệm vụ
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
        local fruitShop = workspace:FindFirstChild("Fruit Shop") -- Thay "Fruit Shop" bằng tên chính xác của Fruit Shop
        if fruitShop then
            hrp.CFrame = fruitShop.PrimaryPart.CFrame
            wait(1)
            local randomFruit = fruitShopItems[math.random(1, #fruitShopItems)]
            print("Đang mua trái ác quỷ: " .. randomFruit)

            -- Logic mua trái ác quỷ (Giả sử có sự kiện để mua trái trong game)
            -- Ví dụ: game:GetService("ReplicatedStorage").Shop:FireServer("Buy", randomFruit)

            wait(5)
        else
            print("Fruit Shop không tìm thấy!")
        end
        wait(10)
    end
end

-- Bắt đầu các chức năng
local function startFeatures()
    spawn(function() if settings.autoChest then autoCollectChest() end end)
    spawn(function() if settings.autoAttackNPC then autoAttackNPC() end end)
    spawn(function() if settings.autoLevelUp then autoLevelUp() end end)
    spawn(function() if settings.antiAFK then antiAFK() end end)
    spawn(function() if settings.autoBuyItems then autoBuyFruits() end end)  -- Thêm autoBuyItems vào
end

-- Bắt đầu script
createMenu()
startFeatures()
print("Script đã được bật thành công!")
