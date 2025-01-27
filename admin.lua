local player = game.Players.LocalPlayer
local gui = player.PlayerGui:WaitForChild("ScreenGui")
local isMenuVisible = false -- Variable to check if the menu is visible

-- Create Main Menu Frame
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 300, 0, 400)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -200) -- Position in the middle of the screen
mainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- Black background
mainFrame.BackgroundTransparency = 0.8 -- Slight transparency
mainFrame.Visible = isMenuVisible -- Menu will be hidden when first joining
mainFrame.Parent = gui

-- Create title for the menu
local title = Instance.new("TextLabel")
title.Text = "Pls Donate Script"
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
title.TextColor3 = Color3.fromRGB(255, 255, 255) -- White text
title.TextSize = 20
title.TextAlign = Enum.TextAlign.Center
title.Parent = mainFrame

-- Create buttons for menu functions
local requestDonationButton = Instance.new("TextButton")
requestDonationButton.Text = "Request Donation"
requestDonationButton.Size = UDim2.new(1, 0, 0, 40)
requestDonationButton.Position = UDim2.new(0, 0, 0, 50)
requestDonationButton.BackgroundColor3 = Color3.fromRGB(255, 255, 0) -- Yellow background
requestDonationButton.TextColor3 = Color3.fromRGB(0, 0, 0) -- Black text
requestDonationButton.TextSize = 18
requestDonationButton.Parent = mainFrame

-- Create Input fields for Name and Robux
local nameInput = Instance.new("TextBox")
nameInput.PlaceholderText = "Enter Name"
nameInput.Size = UDim2.new(1, 0, 0, 40)
nameInput.Position = UDim2.new(0, 0, 0, 100)
nameInput.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
nameInput.TextColor3 = Color3.fromRGB(0, 0, 0)
nameInput.TextSize = 16
nameInput.Parent = mainFrame

local robuxInput = Instance.new("TextBox")
robuxInput.PlaceholderText = "Enter Robux Amount"
robuxInput.Size = UDim2.new(1, 0, 0, 40)
robuxInput.Position = UDim2.new(0, 0, 0, 150)
robuxInput.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
robuxInput.TextColor3 = Color3.fromRGB(0, 0, 0)
robuxInput.TextSize = 16
robuxInput.Parent = mainFrame

-- Notification Label
local notificationLabel = Instance.new("TextLabel")
notificationLabel.Text = "No notifications yet"
notificationLabel.Size = UDim2.new(1, 0, 0, 40)
notificationLabel.Position = UDim2.new(0, 0, 0, 200)
notificationLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255) -- White background
notificationLabel.TextColor3 = Color3.fromRGB(0, 0, 0) -- Black text
notificationLabel.TextSize = 16
notificationLabel.TextAlign = Enum.TextAlign.Center
notificationLabel.Parent = mainFrame

-- Function to request donation
local function requestDonation()
    local name = nameInput.Text
    local robuxAmount = tonumber(robuxInput.Text)

    if name == "" or not robuxAmount then
        notificationLabel.Text = "Please enter a valid name and Robux amount."
    else
        -- Show a notification to the requesting player
        notificationLabel.Text = "You have requested a donation of " .. robuxAmount .. " Robux from " .. name

        -- Send a message to the player
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Donation Request",
            Text = "You requested " .. robuxAmount .. " Robux from " .. name .. ". Please donate if you wish!",
            Duration = 5
        })
    end
end

-- Auto Donate Function
local function autoDonate(targetPlayer, robuxAmount)
    if targetPlayer and robuxAmount and robuxAmount > 0 then
        -- Simulate donation action (can't really donate Robux via script, this is for demo)
        print("Attempting to donate " .. robuxAmount .. " Robux to " .. targetPlayer.Name)

        -- Show notification
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Donation Success",
            Text = "You donated " .. robuxAmount .. " Robux to " .. targetPlayer.Name,
            Duration = 5
        })
    else
        print("Invalid target player or Robux amount")
    end
end

-- VIP Donor Notification
local function notifyVIPDonor(donorPlayer)
    local isVIP = donorPlayer.MembershipType == Enum.MembershipType.Premium
    if isVIP then
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "VIP Donation",
            Text = donorPlayer.Name .. " (VIP) has donated to you! Thank you for being awesome!",
            Duration = 5
        })
    end
end

-- Toggle Menu function
local function toggleMenu()
    isMenuVisible = not isMenuVisible
    mainFrame.Visible = isMenuVisible
end

-- Create Logo (Button to toggle menu)
local logo = Instance.new("ImageButton")
logo.Size = UDim2.new(0, 50, 0, 50)  -- Logo size
logo.Position = UDim2.new(0.5, -25, 0.1, 0)  -- Position near the top-center of the screen
logo.Image = "rbxassetid://1234567890"  -- Replace with your logo's ID
logo.BackgroundTransparency = 1  -- Transparent background
logo.Parent = gui

-- Connect events to buttons
logo.MouseButton1Click:Connect(function()
    print("Logo clicked!")
    toggleMenu() -- When logo is clicked, toggle the menu visibility
end)

requestDonationButton.MouseButton1Click:Connect(function()
    print("Request Donation button clicked!")
    requestDonation()  -- When Request Donation is clicked, perform the donation request
end)

-- Example auto-donate functionality for testing
-- This will simulate a donation process for testing purposes
local targetPlayer = game.Players:FindFirstChild("PlayerName") -- Replace "PlayerName" with the player's name you want to donate to
local robuxAmount = 50 -- The amount of Robux you want to donate
autoDonate(targetPlayer, robuxAmount)

-- Example VIP donation notification
local donorPlayer = game.Players:FindFirstChild("DonorName") -- Replace "DonorName" with the name of the donor
notifyVIPDonor(donorPlayer)
