local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

local function startCrawl(character)
	-- Đảm bảo nhân vật có HRP
	local hrp = character:WaitForChild("HumanoidRootPart")
	local torso = character:FindFirstChild("Torso")
	if not torso then warn("Không tìm thấy torso!") return end

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
	model.Name = player.Name .. "_CrawlModel"

	local function makePart(name, size, offset)
		local p = Instance.new("Part")
		p.Name = name
		p.Size = size
		p.Anchored = true
		p.CanCollide = false
		p.Position = hrp.Position + offset
		p.Color = Color3.fromRGB(160, 100, 60)
		p.Material = Enum.Material.SmoothPlastic
		p.TopSurface = Enum.SurfaceType.Smooth
		p.BottomSurface = Enum.SurfaceType.Smooth
		p.Parent = model
		return p
	end

	local body = makePart("Body", Vector3.new(2,1,1), Vector3.new(0,0,0))
	local head = makePart("Head", Vector3.new(2,1,1), Vector3.new(0,0.6,-1.5))
	local lArm = makePart("LArm", Vector3.new(1,1,1), Vector3.new(-1.2,-0.5,-1))
	local rArm = makePart("RArm", Vector3.new(1,1,1), Vector3.new(1.2,-0.5,-1))
	local lLeg = makePart("LLeg", Vector3.new(1,1,1), Vector3.new(-0.8,-0.5,1.2))
	local rLeg = makePart("RLeg", Vector3.new(1,1,1), Vector3.new(0.8,-0.5,1.2))

	-- Theo dõi di chuyển
	RunService.RenderStepped:Connect(function()
		if not hrp or not model then return end
		local cf = CFrame.new(hrp.Position) * CFrame.Angles(0, hrp.Orientation.Y * math.pi/180, 0)
		body.CFrame = cf
		head.CFrame = cf * CFrame.new(0, 0.6, -1.5)
		lArm.CFrame = cf * CFrame.new(-1.2, -0.5, -1)
		rArm.CFrame = cf * CFrame.new(1.2, -0.5, -1)
		lLeg.CFrame = cf * CFrame.new(-0.8, -0.5, 1.2)
		rLeg.CFrame = cf * CFrame.new(0.8, -0.5, 1.2)
	end)

	-- Hiển thị thông báo thành công
	game.StarterGui:SetCore("ChatMakeSystemMessage", {
		Text = "[✅] Đang bò bằng 4 chân - script hoạt động!";
		Color = Color3.fromRGB(50, 255, 100);
	})
end

-- Khi nhân vật sẵn sàng
if player.Character then
	startCrawl(player.Character)
end

player.CharacterAdded:Connect(startCrawl)
