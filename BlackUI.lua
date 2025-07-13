-- Tạo bảng màu đen (UI)
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")

ScreenGui.Name = "BlackUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

Frame.Name = "BlackPanel"
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.new(0, 0, 0) -- màu đen
Frame.Size = UDim2.new(0, 400, 0, 200) -- kích thước
Frame.Position = UDim2.new(0.5, -200, 0.5, -100) -- căn giữa màn hình
Frame.BorderSizePixel = 0
Frame.BackgroundTransparency = 0.2
