-- VisibilityUI by Yakoney - Fully working template for Loadstring Execution
-- Auto-farm GUI setup (example for a generic farming game)

--// Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local InsertService = game:GetService("InsertService")
local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
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

-- Initialize GUI Prefabs safely
local success, prefab = pcall(function() return InsertService:LoadLocalAsset(PrefabsId) end)
ReGui:Init({ Prefabs = success and prefab or nil })

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

-- Toggle states
local AutoPlant, AutoHarvest, AutoSell, NoClip = false, false, false, false

-- ** Customize these for your game **

-- Example: Remote events/functions (update with your game's remote names)
local PlantSeedEvent = ReplicatedStorage:WaitForChild("PlantSeed") -- change if needed
local HarvestCropEvent = ReplicatedStorage:WaitForChild("HarvestCrop") -- change if needed
local SellCropsEvent = ReplicatedStorage:WaitForChild("SellCrops") -- change if needed

-- Example: how to identify crops/seeds (customize based on your game)
local function GetInvCrops()
    local crops = {}
    for _, item in ipairs(Backpack:GetChildren()) do
        -- Example: crop items contain "Crop" in their name
        if item:IsA("Tool") and string.find(item.Name, "Crop
