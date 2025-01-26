-- Main Frame
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
title.Text = "Admin VIP Menu"
title.TextColor3 = Color3.fromRGB(255, 255, 255)  -- White text
title.TextSize = 24
title.TextAlign = Enum.TextAlign.Center

-- Create Button function
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

-- Functions for Admin
local function addItem()
    print("Add Item clicked!")
    -- Admin functionality: Logic to add item to inventory or display
end

local function removeItem()
    print("Remove Item clicked!")
    -- Admin functionality: Logic to remove item from inventory or display
end

-- Functions for VIP
local function changeBoothColor()
    print("Change Booth Color clicked!")
    -- VIP functionality: Logic to change booth color
end

local function increaseDonations()
    print("Increase Donations clicked!")
    -- VIP functionality: Logic to give more Robux or donation benefits
end

-- Check if player is admin
local function isAdmin(player)
    -- Replace with your actual admin check (e.g., check for group rank, game pass, etc.)
    return player.UserId == 123456789  -- Example: change this to a specific user ID or other check
end

-- Check if player is VIP
local function isVIP(player)
    -- Replace with your actual VIP check (e.g., check for group rank, game pass, etc.)
    return player.UserId == 987654321  -- Example: change this to a specific user ID or other check
end

-- Display Buttons for Admins and VIPs
local yPosition = 0.1  -- Starting Y position for buttons

if isAdmin(player) then
    -- Admin specific buttons
    createButton("Add Item", UDim2.new(0, 0, yPosition, 0), addItem)
    yPosition = yPosition + 0.1
    createButton("Remove Item", UDim2.new(0, 0, yPosition, 0), removeItem)
    yPosition = yPosition + 0.1
end

if isVIP(player) then
    -- VIP specific button to change booth color
    createButton("VIP: Change Booth Color (Free)", UDim2.new(0, 0, yPosition, 0), changeBoothColor)
    yPosition = yPosition + 0.1
    -- VIP specific button to increase donations
    createButton("VIP: Increase Donations", UDim2.new(0, 0, yPosition, 0), increaseDonations)
    yPosition = yPosition + 0.1
end

-- Function to Auto Jump to Server with High Donations
local function autoJoinTopServer()
    -- Logic to find and join the server with the most donations
    print("Jumping to the server with the highest donations...")
end

-- Add Auto-Join Top Server Button for Admin
if isAdmin(player) then
    createButton("Auto Join Top Server", UDim2.new(0, 0, yPosition, 0), autoJoinTopServer)
    yPosition = yPosition + 0.1
end
