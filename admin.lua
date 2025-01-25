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

-- Add item function
local function addItem()
    -- Implement your logic for adding an item here
    print("Add Item clicked!")
end

-- Remove item function
local function removeItem()
    -- Implement your logic for removing an item here
    print("Remove Item clicked!")
end

-- Change booth color function
local function changeBoothColor()
    -- Implement your logic for changing booth color here
    print("Change Booth Color clicked!")
end

-- Create buttons for the menu
createButton("Add Item", UDim2.new(0, 0, 0.1, 0), addItem)
createButton("Remove Item", UDim2.new(0, 0, 0.2, 0), removeItem)
createButton("Change Booth Color", UDim2.new(0, 0, 0.3, 0), changeBoothColor)

-- Admin and VIP Functions (Permissions check)
local isAdmin = false  -- Set this to true if the player is an admin
local isVIP = false    -- Set this to true if the player is VIP

-- Example of VIP feature: VIP can change booth color for free
if isVIP then
    -- Add VIP specific features here (like free booth color change)
    local vipBoothColorChange = Instance.new("TextButton")
    vipBoothColorChange.Parent = frame
    vipBoothColorChange.Size = UDim2.new(1, 0, 0.1, 0)
    vipBoothColorChange.Position = UDim2.new(0, 0, 0.4, 0)
    vipBoothColorChange.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    vipBoothColorChange.TextColor3 = Color3.fromRGB(0, 255, 0)
    vipBoothColorChange.Text = "VIP: Change Booth Color (Free)"
    vipBoothColorChange.TextSize = 20
    vipBoothColorChange.TextAlign = Enum.TextAlign.Center
    vipBoothColorChange.MouseButton1Click:Connect(changeBoothColor)
end

-- Example of Admin features: Admins can add/remove items
if isAdmin then
    -- Admin-specific functionality can be added here, such as item management
    local adminAddItemButton = Instance.new("TextButton")
    adminAddItemButton.Parent = frame
    adminAddItemButton.Size = UDim2.new(1, 0, 0.1, 0)
    adminAddItemButton.Position = UDim2.new(0, 0, 0.5, 0)
    adminAddItemButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    adminAddItemButton.TextColor3 = Color3.fromRGB(0, 255, 0)
    adminAddItemButton.Text = "Admin: Add Item"
    adminAddItemButton.TextSize = 20
    adminAddItemButton.TextAlign = Enum.TextAlign.Center
    adminAddItemButton.MouseButton1Click:Connect(addItem)
end
