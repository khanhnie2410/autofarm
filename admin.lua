-- GUI setup for Admin and VIP Menu
local player = game.Players.LocalPlayer
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Full Script (Server + Client) for Donation and Admin Functions
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DonationEvent = Instance.new("RemoteEvent", ReplicatedStorage)
DonationEvent.Name = "ForceDonation"

local MIN_DONATE_AMOUNT = 5  -- Minimum Robux to donate

-- Function to check if the player is an admin
local function isAdmin(player)
    -- The player who runs the script (turns it on) will be the admin
    return player == game.Players.LocalPlayer
end

-- Server-Side Donation Handling
DonationEvent.OnServerEvent:Connect(function(player, targetPlayer, amount)
    if not isAdmin(player) then
        player:Kick("You do not have permission to donate.")
        return
    end

    if targetPlayer and amount >= MIN_DONATE_AMOUNT then
        local success, err = pcall(function()
            -- Simulate the donation process
            print(player.Name .. " donated " .. amount .. " Robux to " .. targetPlayer.Name)
        end)

        if success then
            player:Kick("Donation of " .. amount .. " Robux successfully sent to " .. targetPlayer.Name)
        else
            warn("Error during donation: " .. err)
        end
    else
        player:Kick("You must donate at least " .. MIN_DONATE_AMOUNT .. " Robux.")
    end
end)

-- Client-Side Donation Interface
local function createDonationInterface()
    local gui = Instance.new("ScreenGui")
    gui.Name = "DonationInterface"
    gui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    local frame = Instance.new("Frame", gui)
    frame.Size = UDim2.new(0.3, 0, 0.3, 0)
    frame.Position = UDim2.new(0.35, 0, 0.35, 0)
    frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    frame.BorderSizePixel = 0

    local titleLabel = Instance.new("TextLabel", frame)
    titleLabel.Size = UDim2.new(1, 0, 0.2, 0)
    titleLabel.Position = UDim2.new(0, 0, 0, 0)
    titleLabel.Text = "Force Donation"
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Font = Enum.Font.SourceSansBold
    titleLabel.TextSize = 20

    local robuxLabel = Instance.new("TextLabel", frame)
    robuxLabel.Size = UDim2.new(1, 0, 0.15, 0)
    robuxLabel.Position = UDim2.new(0, 0, 0.2, 0)
    robuxLabel.Text = "Enter Robux Amount (5+):"
    robuxLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    robuxLabel.BackgroundTransparency = 1
    robuxLabel.Font = Enum.Font.SourceSans
    robuxLabel.TextSize = 16

    local robuxBox = Instance.new("TextBox", frame)
    robuxBox.Size = UDim2.new(1, 0, 0.15, 0)
    robuxBox.Position = UDim2.new(0, 0, 0.35, 0)
    robuxBox.PlaceholderText = "Enter amount"
    robuxBox.Text = ""
    robuxBox.Font = Enum.Font.SourceSans
    robuxBox.TextSize = 16
    robuxBox.TextColor3 = Color3.fromRGB(0, 0, 0)

    local donateButton = Instance.new("TextButton", frame)
    donateButton.Size = UDim2.new(0.5, 0, 0.2, 0)
    donateButton.Position = UDim2.new(0.25, 0, 0.6, 0)
    donateButton.Text = "Donate"
    donateButton.Font = Enum.Font.SourceSansBold
    donateButton.TextSize = 18
    donateButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    donateButton.BackgroundColor3 = Color3.fromRGB(100, 200, 100)

    donateButton.MouseButton1Click:Connect(function()
        local amount = tonumber(robuxBox.Text)
        local targetPlayerName = "TargetPlayer"  -- Replace with actual logic for target selection
        local targetPlayer = game.Players:FindFirstChild(targetPlayerName)

        if targetPlayer and amount and amount >= 5 then
            DonationEvent:FireServer(targetPlayer, amount)
        else
            warn("Invalid donation: Enter a valid target player and amount (5+).")
        end
    end)
end

-- Add the donation interface when the player joins
game.Players.LocalPlayer.CharacterAdded:Connect(function()
    createDonationInterface()
end)

-- Admin Commands
local adminCommands = {
    ["kick"] = function(targetPlayer)
        if isAdmin(game.Players.LocalPlayer) then
            targetPlayer:Kick("You have been kicked by an admin.")
        end
    end,
    ["shutdown"] = function()
        if isAdmin(game.Players.LocalPlayer) then
            game:Shutdown()
        end
    end
}

-- Handle Admin Commands
game:GetService("ReplicatedStorage").OnServerEvent:Connect(function(player, command, targetPlayerName)
    if isAdmin(player) then
        local targetPlayer = game.Players:FindFirstChild(targetPlayerName)
        if adminCommands[command] then
            adminCommands[command](targetPlayer)
        end
    else
        player:Kick("You do not have permission to execute this command.")
    end
end)
