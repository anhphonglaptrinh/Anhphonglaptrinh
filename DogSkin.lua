local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

-- Đảm bảo nhân vật đứng yên lúc bắt đầu
hrp.Anchored = true

-- Ẩn toàn bộ nhân vật
for _, v in pairs(char:GetDescendants()) do
	if v:IsA("BasePart") then
		v.Transparency = 1
	elseif v:IsA("Accessory") or v:IsA("Decal") then
		v:Destroy()
	end
end

-- Tạo mô hình chó
local dogModel = Instance.new("Model", workspace)
dogModel.Name = "PhongDog"

-- Tạo Part đơn giản
local function makePart(name, size, color, pos)
	local p = Instance.new("Part")
	p.Name = name
	p.Size = size
	p.Position = pos
	p.Color = color
	p.Anchored = false
	p.CanCollide = false
	p.Material = Enum.Material.SmoothPlastic
	p.TopSurface = Enum.SurfaceType.Smooth
	p.BottomSurface = Enum.SurfaceType.Smooth
	p.Parent = dogModel
	return p
end

-- Core gốc neo mô hình
local core = makePart("Core", Vector3.new(1,1,1), Color3.new(1,1,1), hrp.Position + Vector3.new(0, 3, 0))
core.Transparency = 1
core.Anchored = true
dogModel.PrimaryPart = core

-- Tạo thân chó
local body = makePart("Body", Vector3.new(4, 2, 6), Color3.fromRGB(120, 80, 50), core.Position)
local head = makePart("Head", Vector3.new(2, 2, 2), Color3.fromRGB(140, 90, 60), body.Position + Vector3.new(0, 1.5, -3))
local face = makePart("Face", Vector3.new(0.5, 0.5, 0.5), Color3.new(0, 0, 0), head.Position + Vector3.new(0, 0, -1.2))
local tail = makePart("Tail", Vector3.new(0.5, 1.5, 0.5), body.Position + Vector3.new(0, 0.5, 3.2), Color3.fromRGB(100,70,50))
local earL = makePart("EarL", Vector3.new(0.5, 1, 0.5), Color3.fromRGB(90,60,40), head.Position + Vector3.new(-0.6, 1, 0))
local earR = makePart("EarR", Vector3.new(0.5, 1, 0.5), Color3.fromRGB(90,60,40), head.Position + Vector3.new(0.6, 1, 0))

-- 4 chân
local legs = {
	Vector3.new(-1.5, -1, -2.5), Vector3.new(1.5, -1, -2.5),
	Vector3.new(-1.5, -1, 2.5), Vector3.new(1.5, -1, 2.5),
}
for i, offset in ipairs(legs) do
	makePart("Leg"..i, Vector3.new(0.8,2,0.8), Color3.fromRGB(120,80,50), core.Position + offset)
end

-- Weld tất cả vào core
for _, part in ipairs(dogModel:GetChildren()) do
	if part:IsA("BasePart") and part ~= core then
		local w = Instance.new("WeldConstraint")
		w.Part0 = part
		w.Part1 = core
		w.Parent = part
	end
end

-- Đảm bảo map đã load xong trước khi thả xuống
task.delay(1.5, function()
	core.Anchored = false

	local weld = Instance.new("WeldConstraint")
	weld.Part0 = core
	weld.Part1 = hrp
	weld.Parent = core

	hrp.Anchored = false -- thả nhân vật hoạt động bình thường
end)

-- Hướng theo nhân vật
RunService.RenderStepped:Connect(function()
	if not core.Anchored then
		core.CFrame = CFrame.new(hrp.Position) * CFrame.Angles(0, math.rad(hrp.Orientation.Y), 0)
	end
end)

-- Đuôi vẫy
task.spawn(function()
	while true do
		local a = TweenService:Create(tail, TweenInfo.new(0.4, Enum.EasingStyle.Sine), {
			CFrame = tail.CFrame * CFrame.Angles(math.rad(15), 0, 0)
		})
		local b = TweenService:Create(tail, TweenInfo.new(0.4, Enum.EasingStyle.Sine), {
			CFrame = tail.CFrame * CFrame.Angles(math.rad(-15), 0, 0)
		})
		a:Play()
		a.Completed:Wait()
		b:Play()
		b.Completed:Wait()
	end
end)

-- Thân chuyển động nhẹ
task.spawn(function()
	while true do
		local up = TweenService:Create(core, TweenInfo.new(1, Enum.EasingStyle.Sine), {
			Position = hrp.Position + Vector3.new(0, 0.4, 0)
		})
		local down = TweenService:Create(core, TweenInfo.new(1, Enum.EasingStyle.Sine), {
			Position = hrp.Position
		})
		up:Play()
		up.Completed:Wait()
		down:Play()
		down.Completed:Wait()
	end
end)
