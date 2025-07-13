local TweenService = game:GetService("TweenService")
local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

-- Ẩn tất cả Part, phụ kiện, biểu cảm
for _, v in pairs(char:GetDescendants()) do
	if v:IsA("BasePart") then v.Transparency = 1 end
	if v:IsA("Accessory") or v:IsA("Decal") then v:Destroy() end
end

-- Tạo mô hình chó
local dogModel = Instance.new("Model", workspace)
dogModel.Name = "DogCharacter"

local function part(name, size, color, pos, parent)
	local p = Instance.new("Part")
	p.Name = name
	p.Size = size
	p.Color = color
	p.Anchored = false
	p.CanCollide = false
	p.Position = pos
	p.Material = Enum.Material.SmoothPlastic
	p.Parent = parent
	p.TopSurface = Enum.SurfaceType.Smooth
	p.BottomSurface = Enum.SurfaceType.Smooth
	return p
end

-- Cấu trúc thân chó
local basePos = hrp.Position
local body = part("Body", Vector3.new(4, 2, 6), Color3.fromRGB(120, 80, 50), basePos, dogModel)
local head = part("Head", Vector3.new(2, 2, 2), Color3.fromRGB(140, 90, 60), basePos + Vector3.new(0, 1.5, -4), dogModel)
local face = part("Face", Vector3.new(0.5, 0.5, 0.5), Color3.new(0, 0, 0), head.Position + Vector3.new(0, 0, -1.2), dogModel)

-- Tai
local earL = part("EarL", Vector3.new(0.5, 1, 0.5), Color3.fromRGB(90, 60, 40), head.Position + Vector3.new(-0.6, 1, 0), dogModel)
local earR = part("EarR", Vector3.new(0.5, 1, 0.5), Color3.fromRGB(90, 60, 40), head.Position + Vector3.new(0.6, 1, 0), dogModel)

-- Chân
local legOffsets = {
	Vector3.new(-1.5, -1, -2.5), Vector3.new(1.5, -1, -2.5),
	Vector3.new(-1.5, -1, 2.5), Vector3.new(1.5, -1, 2.5),
}
for i, offset in ipairs(legOffsets) do
	part("Leg" .. i, Vector3.new(0.8, 2, 0.8), Color3.fromRGB(120, 80, 50), basePos + offset, dogModel)
end

-- Đuôi
local tail = part("Tail", Vector3.new(0.5, 1.5, 0.5), Color3.fromRGB(100, 70, 50), body.Position + Vector3.new(0, 0.5, 3.5), dogModel)

-- Weld function
local function weld(p1, p2)
	local w = Instance.new("WeldConstraint", p1)
	w.Part0 = p1
	w.Part1 = p2
end

-- Gắn phần thân
for _, p in ipairs(dogModel:GetChildren()) do
	if p:IsA("BasePart") and p ~= body then
		weld(p, body)
	end
end
weld(body, hrp)

-- Theo hướng nhìn nhân vật
game:GetService("RunService").RenderStepped:Connect(function()
	body.CFrame = CFrame.new(hrp.Position) * CFrame.Angles(0, hrp.Orientation.Y * math.pi/180, 0)
end)

-- Đuôi vẫy
task.spawn(function()
	while true do
		local t1 = TweenService:Create(tail, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
			CFrame = tail.CFrame * CFrame.Angles(math.rad(20), 0, 0)
		})
		local t2 = TweenService:Create(tail, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
			CFrame = tail.CFrame * CFrame.Angles(math.rad(-20), 0, 0)
		})
		t1:Play()
		t1.Completed:Wait()
		t2:Play()
		t2.Completed:Wait()
	end
end)

-- Cơ thể nâng/hạ nhẹ
task.spawn(function()
	while true do
		local up = TweenService:Create(body, TweenInfo.new(1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
			Position = basePos + Vector3.new(0, 0.5, 0)
		})
		local down = TweenService:Create(body, TweenInfo.new(1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
			Position = basePos + Vector3.new(0, -0.2, 0)
		})
		up:Play()
		up.Completed:Wait()
		down:Play()
		down.Completed:Wait()
	end
end)
