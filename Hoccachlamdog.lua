local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- Ẩn nhân vật thật
for _, v in ipairs(character:GetChildren()) do
	if v:IsA("BasePart") then
		v.Transparency = 1
		v.CanCollide = false
	elseif v:IsA("Accessory") or v:IsA("Hat") then
		v:Destroy()
	end
end

-- Tạo mô hình R6 bò
local model = Instance.new("Model", workspace)
model.Name = "CrawlR6"

-- Hàm tạo part
local function makePart(name, size, color, pos)
	local part = Instance.new("Part")
	part.Name = name
	part.Size = size
	part.Position = pos
	part.Anchored = true
	part.Color = color
	part.CanCollide = false
	part.Material = Enum.Material.SmoothPlastic
	part.TopSurface = Enum.SurfaceType.Smooth
	part.BottomSurface = Enum.SurfaceType.Smooth
	part.Parent = model
	return part
end

-- Thân và đầu
local rootPos = character:WaitForChild("HumanoidRootPart").Position
local torso = makePart("Torso", Vector3.new(2, 1, 1), Color3.fromRGB(170, 120, 80), rootPos)
local head = makePart("Head", Vector3.new(2, 1, 1), Color3.fromRGB(200, 160, 120), torso.Position + Vector3.new(0, 0.8, -1.2))

-- Tay và chân
local function limb(name, offset)
	return makePart(name, Vector3.new(1, 1, 1), torso.Color, torso.Position + offset)
end

local limbs = {
	limb("LeftArm", Vector3.new(-1.2, -0.5, -1)),
	limb("RightArm", Vector3.new(1.2, -0.5, -1)),
	limb("LeftLeg", Vector3.new(-0.8, -0.5, 1.2)),
	limb("RightLeg", Vector3.new(0.8, -0.5, 1.2)),
}

-- Cập nhật vị trí mô hình theo nhân vật
RunService.RenderStepped:Connect(function()
	local hrp = character:FindFirstChild("HumanoidRootPart")
	if not hrp then return end
	local cf = CFrame.new(hrp.Position) * CFrame.Angles(0, hrp.Orientation.Y * math.pi/180, 0)
	torso.CFrame = cf
	head.CFrame = cf * CFrame.new(0, 0.8, -1.2)
	limbs[1].CFrame = cf * CFrame.new(-1.2, -0.5, -1)
	limbs[2].CFrame = cf * CFrame.new(1.2, -0.5, -1)
	limbs[3].CFrame = cf * CFrame.new(-0.8, -0.5, 1.2)
	limbs[4].CFrame = cf * CFrame.new(0.8, -0.5, 1.2)
end)
