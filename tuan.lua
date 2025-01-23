local ScreenGui = Instance.new("ScreenGui", game.Players.LocalPlayer:WaitForChild("PlayerGui"))
ScreenGui.Name = "CustomMenu"

-- Main Menu
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 300, 0, 500)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -250)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Visible = true

local ToggleButton = Instance.new("TextButton", ScreenGui)
ToggleButton.Size = UDim2.new(0, 100, 0, 40)
ToggleButton.Position = UDim2.new(0.5, -50, 0, 10)
ToggleButton.Text = "Toggle Menu"
ToggleButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)

ToggleButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- Add Logo
local Logo = Instance.new("ImageLabel", MainFrame)
Logo.Size = UDim2.new(0, 100, 0, 100)
Logo.Position = UDim2.new(0.5, -50, 0, 10) -- Centered at the top
Logo.BackgroundTransparency = 1
Logo.Image = "rbxassetid://140432928117878"

-- Function to create categories
local function createCategory(name, positionY)
    local CategoryFrame = Instance.new("Frame", MainFrame)
    CategoryFrame.Size = UDim2.new(0, 300, 0, 100)
    CategoryFrame.Position = UDim2.new(0, 0, 0, positionY)
    CategoryFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)

    local CategoryLabel = Instance.new("TextLabel", CategoryFrame)
    CategoryLabel.Size = UDim2.new(1, 0, 0, 30)
    CategoryLabel.Text = name
    CategoryLabel.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    CategoryLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    CategoryLabel.Font = Enum.Font.SourceSansBold
    CategoryLabel.TextSize = 18

    return CategoryFrame
end

-- Function to create buttons
local function createButton(parent, text, positionY, callback)
    local Button = Instance.new("TextButton", parent)
    Button.Size = UDim2.new(0, 260, 0, 30)
    Button.Position = UDim2.new(0, 20, 0, positionY)
    Button.Text = text
    Button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.Font = Enum.Font.SourceSans
    Button.TextSize = 14

    Button.MouseButton1Click:Connect(callback)
    return Button
end

-- Auto Farm Category
local AutoFarmFrame = createCategory("Auto Farm", 120)
createButton(AutoFarmFrame, "Start Auto Farm", 40, function()
    print("Auto Farm Started!")
end)
createButton(AutoFarmFrame, "Stop Auto Farm", 80, function()
    print("Auto Farm Stopped!")
end)

-- Auto Quest Category
local AutoQuestFrame = createCategory("Auto Quest", 240)
createButton(AutoQuestFrame, "Start Auto Quest", 40, function()
    print("Auto Quest Started!")
end)
createButton(AutoQuestFrame, "Stop Auto Quest", 80, function()
    print("Auto Quest Stopped!")
end)

-- Teleport Category
local TeleportFrame = createCategory("Teleport", 360)
createButton(TeleportFrame, "Teleport to NPC", 40, function()
    print("Teleported to NPC!")
end)
createButton(TeleportFrame, "Teleport to Island", 80, function()
    print("Teleported to Island!")
end)

-- Shop Category
local ShopFrame = createCategory("Shop", 480)
createButton(ShopFrame, "Buy Health Potion", 40, function()
    print("Health Potion Purchased!")
end)
createButton(ShopFrame, "Buy Stamina Potion", 80, function()
    print("Stamina Potion Purchased!")
end)

-- Settings Category
local SettingsFrame = createCategory("Settings", 600)
createButton(SettingsFrame, "Toggle God Mode", 40, function()
    print("God Mode Toggled!")
end)
createButton(SettingsFrame, "Toggle Anti AFK", 80, function()
    print("Anti AFK Toggled!")
end)

print("Script has been successfully initialized with logo!")
