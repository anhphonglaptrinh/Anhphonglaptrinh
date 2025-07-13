local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()

-- Ẩn nhân vật gốc
for _, part in ipairs(char:GetChildren()) do
	if part:IsA("BasePart") then
		part.Transparency = 1
	end
end

-- Tạo mô hình chó
local dogModel = Instance.new("Model", workspace)
dogModel.Name = "PhongDog"

-- Thân chó
local body = Instance.new("Part", dogModel)
body.Size = Vector3.new(4, 2, 6)
body.Position = char.HumanoidRootPart.Position
body.Anchored = false
body.CanCollide = false
body.Color = Color3.fromRGB(160, 120, 80)
body.Name = "Body"

-- Đầu
local head = Instance.new("Part", dogModel)
head.Size = Vector3.new(2, 2, 2)
head.Position = body.Position + Vector3.new(0, 1, -3)
head.Anchored = false
head.CanCollide = false
head.Color = Color3.fromRGB(160, 120, 80)
head.Name = "Head"

-- Tai trái
local ear1 = Instance.new("Part", dogModel)
ear1.Size = Vector3.new(0.5, 1, 0.5)
ear1.Position = head.Position + Vector3.new(-0.6, 1, 0)
ear1.Anchored = false
ear1.Color = Color3.fromRGB(100, 70, 50)
ear1.CanCollide = false
ear1.Name = "EarL"

-- Tai phải
local ear2 = Instance.new("Part", dogModel)
ear2.Size = Vector3.new(0.5, 1, 0.5)
ear2.Position = head.Position + Vector3.new(0.6, 1, 0)
ear2.Anchored = false
ear2.Color = Color3.fromRGB(100, 70, 50)
ear2.CanCollide = false
ear2.Name = "EarR"

-- Đuôi
local tail = Instance.new("Part", dogModel)
tail.Size = Vector3.new(0.5, 1.5, 0.5)
tail.Position = body.Position + Vector3.new(0, 0.5, 3.2)
tail.Anchored = false
tail.CanCollide = false
tail.Color = Color3.fromRGB(120, 90, 60)
tail.Name = "Tail"

-- Gắn tất cả bộ phận vào nhân vật
local function weld(p1, p2)
	local weld = Instance.new("WeldConstraint")
	weld.Part0 = p1
	weld.Part1 = p2
	weld.Parent = p1
end

weld(body, char.HumanoidRootPart)
weld(head, body)
weld(ear1, head)
weld(ear2, head)
weld(tail, body)
