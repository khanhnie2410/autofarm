-- GUI setup for Admin and VIP Menu
local player = game.Players.LocalPlayer
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Parent = screenGui
frame.Size = UDim2.new(0.3, 0, 0.5, 0)
frame.Position = UDim2.new(0.35, 0, 0.25, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)  -- Dark background
frame.BorderSizePixel = 0

-- Title for the menu
local title = Instance.new("TextLabel")
title.Parent = frame
title.Size = UDim2.new(1, 0, 0.1, 0)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.Text = "Admin Menu"
title.TextColor3 = Color3.fromRGB(255, 255, 255)  -- White text
title.TextSize = 24
title.TextAlign = Enum.TextAlign.Center

-- Function to create a button
local function createButton(name, position, func)
    local button = Instance.new("TextButton")
    button.Parent = frame
    button.Size = UDim2.new(1, 0, 0.1, 0)
    button.Position = position
    button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)  -- Dark button color
    button.TextColor3 = Color3.fromRGB(0, 255, 0)  -- Green text
    button.Text = name
    button.TextSize = 20
    button.TextAlign = Enum.TextAlign.Center
    button.MouseButton1Click:Connect(func)
end

-- Add item function (for Admin)
local function addItem()
    print("Add Item clicked!")
    -- Add your logic to add items here
end

-- Remove item function (for Admin)
local function removeItem()
    print("Remove Item clicked!")
    -- Add your logic to remove items here
end

-- Change booth color function (for VIP)
local function changeBoothColor()
    print("Change Booth Color clicked!")
    -- Add your logic to change booth color here
end

-- Admin function to check if player is Admin
local function isAdmin(player)
    -- Replace with your actual admin check (e.g., check for group rank, game pass, etc.)
    return player.UserId == 123456789 -- Example: change this to a specific user ID or other check
end

-- VIP function to check if player is VIP
local function isVIP(player)
    -- Replace with your actual VIP check (e.g., check for group rank, game pass, etc.)
    return player.UserId == 987654321 -- Example: change this to a specific user ID or other check
end

-- Example of adding functionality based on Admin and VIP status
if isAdmin(player) then
    -- Admin specific buttons
    createButton("Add Item", UDim2.new(0, 0, 0.1, 0), addItem)
    createButton("Remove Item", UDim2.new(0, 0, 0.2, 0), removeItem)
end

if isVIP(player) then
    -- VIP specific button
    createButton("VIP: Change Booth Color (Free)", UDim2.new(0, 0, 0.3, 0), changeBoothColor)
end
