-- VisibilityUI by Yakoney - Fixed for Loadstring Execution
-- Auto‑farm GUI setup (placeholder for Grow a Garden)

--// Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local InsertService = game:GetService("InsertService")
local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local Leaderstats = LocalPlayer:WaitForChild("leaderstats")
local Backpack = LocalPlayer:WaitForChild("Backpack")
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- UI Library: ReGui
local ReGui = loadstring(game:HttpGet(
    'https://raw.githubusercontent.com/depthso/Dear-ReGui/refs/heads/main/ReGui.lua'
))()
local PrefabsId = "rbxassetid://" .. tostring(ReGui.PrefabsId or "")

-- Colors
local Accent = {
    DarkGreen = Color3.fromRGB(45, 95, 25),
    Green = Color3.fromRGB(69, 142, 40),
    Brown = Color3.fromRGB(26, 20, 8),
}

-- Initialize GUI
if PrefabsId == "rbxassetid://" then
    warn("ReGui.PrefabsId is missing or invalid.")
end

ReGui:Init({ Prefabs = pcall(InsertService.LoadLocalAsset, InsertService, PrefabsId) and InsertService:LoadLocalAsset(PrefabsId) or nil })
ReGui:DefineTheme("VisibilityUI", {
    WindowBg = Accent.Brown,
    TitleBarBg = Accent.DarkGreen,
    TitleBarBgActive = Accent.Green,
    ResizeGrab = Accent.DarkGreen,
    FrameBg = Accent.DarkGreen,
    FrameBgActive = Accent.Green,
    CollapsingHeaderBg = Accent.Green,
    ButtonsBg = Accent.Green,
    CheckMark = Accent.Green,
    SliderGrab = Accent.Green,
})

-- Placeholder globals
local AutoPlant, AutoHarvest, AutoSell, NoClip = false, false, false, false

-- Placeholder functions to avoid errors
function GetInvCrops() return {} end
function SellInventory() warn("SellInventory not implemented yet.") end
function StartServices() warn("StartServices not implemented yet.") end

-- Create main window
local function CreateWindow()
    local Window = ReGui:Window({
        Title = "VisibilityUI by Yakoney",
        Theme = "VisibilityUI",
        Size = UDim2.fromOffset(300, 200),
    })
    return Window
end

local Window = CreateWindow()

-- Toolbar toggles
Window:Toggle({ Text = "Auto Plant", Default = false, Callback = function(v) AutoPlant = v end })
Window:Toggle({ Text = "Auto Harvest", Default = false, Callback = function(v) AutoHarvest = v end })
Window:Toggle({ Text = "Auto Sell", Default = false, Callback = function(v) AutoSell = v end })
Window:Toggle({ Text = "No Clip", Default = false, Callback = function(v) NoClip = v end })

-- Core logic connections
RunService.Stepped:Connect(function()
    if NoClip then
        local char = LocalPlayer.Character
        if char then
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = false end
            end
        end
    end
end)

Backpack.ChildAdded:Connect(function()
    if AutoSell then
        if #GetInvCrops() >= (SellInventory and 1 or 0) then
            SellInventory()
        end
    end
end)

-- Starting up automation routines
StartServices()

print("VisibilityUI by Yakoney loaded successfully")
