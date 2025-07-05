--[[ VisibilityUI by Yakoney
     Created for Grow a Garden or similar Roblox games.
     Toggles transparency of common objects.
]]

-- UI Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VisibilityUI"
ScreenGui.Parent = game.CoreGui

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 200, 0, 160)
Frame.Position = UDim2.new(0, 20, 0, 100)
Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Frame.BorderSizePixel = 0
Frame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundTransparency = 1
Title.Text = "VisibilityUI by Yakoney"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 20
Title.Parent = Frame

local Toggle = Instance.new("TextButton")
Toggle.Size = UDim2.new(1, -20, 0, 40)
Toggle.Position = UDim2.new(0, 10, 0, 50)
Toggle.Text = "Toggle Transparency"
Toggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
Toggle.Font = Enum.Font.SourceSans
Toggle.TextSize = 16
Toggle.Parent = Frame

-- Functionality
local transparent = false
Toggle.MouseButton1Click:Connect(function()
    transparent = not transparent
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") then
            if transparent then
                obj.Transparency = 0.6
                obj.CanCollide = false
            else
                obj.Transparency = 0
                obj.CanCollide = true
            end
        end
    end
    Toggle.Text = transparent and "Restore Visibility" or "Toggle Transparency"
end)
